class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    auth = request.env['omniauth.auth']
    a = auth.uid
    user = find_user_from_auth(auth)
    if user
      user.update(uid: auth.uid)
    else
      user = User.from_omniauth(auth)
    end
    session[:user_id] = user.id

    redirect_to(
      success_url,
      notice: t('omniauth_callbacks.success')
    )
  end

  def destroy
    if params[:SAMLRequest]
      idp_logout_request
    elsif params[:SAMLResponse]
      validate_slo_response
    else
      sp_logout_request
    end
  end

  def failure
    flash[:alert] = t('omniauth_callbacks.failure', reason: failure_message)
    redirect_to failure_url
  end

  def setup
    if params.key?(:loa)
      request.env['omniauth.strategy'].options[:authn_context] = [
        "http://idmanagement.gov/ns/assurance/loa/#{params[:loa]}",
        'http://idmanagement.gov/ns/requested_attributes?ReqAttr=email,phone,first_name,last_name,ssn'
      ]
    end
    render text: 'Omniauth setup phase.', status: 404
  end

  private

  def saml_settings
    @_saml_settings ||= OneLogin::RubySaml::Settings.new(SAML_SETTINGS)
  end

  def failure_message
    env['omniauth.error.type'].to_s.humanize
  end

  def validate_slo_response
    slo_response = idp_logout_response
    if slo_response.validate
      flash[:notice] = t('omniauth_callbacks.logout_ok')
      redirect_to root_url
    else
      flash[:alert] = t('omniauth_callbacks.logout_fail')
      redirect_to failure_url
    end
  end

  def idp_logout_response
    OneLogin::RubySaml::Logoutresponse.new(params[:SAMLResponse], saml_settings)
  end

  def sp_logout_request
    current_user = User.find(session[:user_id])
    settings = saml_settings.dup
    settings.name_identifier_value = current_user.uid
    logout_request = OneLogin::RubySaml::Logoutrequest.new.create(settings)
    redirect_to logout_request
  end

  def idp_logout_request
    logout_request = OneLogin::RubySaml::SloLogoutrequest.new(
      params[:SAMLRequest],
      settings: saml_settings
    )
    if logout_request.is_valid?
      redirect_to_logout(logout_request)
    else
      render_logout_error(logout_request)
    end
  end

  def redirect_to_logout(logout_request)
    Rails.logger.info "IdP initiated Logout for #{logout_request.nameid}"
    sign_out
    logout_response = OneLogin::RubySaml::SloLogoutresponse.new.create(
      saml_settings,
      logout_request.id,
      nil,
      RelayState: params[:RelayState]
    )
    redirect_to logout_response
  end

  def render_logout_error(logout_request)
    error_msg = "IdP initiated LogoutRequest was not valid: #{logout_request.errors}"
    Rails.logger.error error_msg
    render inline: error_msg
  end

  def sign_out
    # if this were a Devise controller, sign_out is built-in
    # so this is just an example no-op
  end

  def find_user_from_auth(auth)
    user = User.find_by uid: auth.uid
    unless user
      user = User.find_by_email(auth.email)
      unless user
        return nil unless auth.key?('extra')
        auth_info = auth.info
        user = User.where("first_name = :first_name AND last_name = :last_name AND social_security_number = :ssn",
                          {first_name: auth_info.first_name, last_name: auth_info.last_name, ssn: auth.extra.raw_info[:ssn]})
        case user.length
          when 0
            return nil
          when 1
            return user.first
          else
            #We should probably respond more constructively here
            raise "too many matching records!"
        end
      end
    end
    user
  end
end
