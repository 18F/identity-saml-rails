class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id

    redirect_to(
      success_url,
      notice: t('omniauth_callbacks.success')
    )
  end

  def destroy
    if params[:SAMLRequest]
      idp_logout_request
    else
      flash[:alert] = 'SAMLRequest missing'
      redirect_to failure_url
    end
  end

  def failure
    flash[:alert] = t('omniauth_callbacks.failure', reason: failure_message)
    redirect_to failure_url
  end

  private

  def saml_settings
    @_saml_settings ||= OneLogin::RubySaml::Settings.new(SAML_SETTINGS)
  end

  def failure_message
    env['omniauth.error.type'].to_s.humanize
  end

  def idp_logout_request
    logout_request = OneLogin::RubySaml::SloLogoutrequest.new(
      params[:SAMLRequest],
      settings: saml_settings
    )
    if logout_request.is_valid?
      redirect_to_logout(logout_request)
    else
      render_logout_error
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
end
