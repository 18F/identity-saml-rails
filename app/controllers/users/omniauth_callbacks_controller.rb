class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def saml
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "IdP") if is_navigational_format?
    else
      session["devise.saml_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
      flash[:error] = 'Sorry, we could not authenticate you. Please try again later.'
    end
  end

  def failure
    redirect_to root_path
    flash[:error] = 'Sorry, we could not authenticate you. Please try again later.'
  end
end
