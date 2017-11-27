class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  if !Rails.application.secrets.http_auth_username.nil? &&
     !Rails.application.secrets.http_auth_password.nil?
    http_basic_authenticate_with(
      name: Rails.application.secrets.http_auth_username,
      password: Rails.application.secrets.http_auth_password
    )
  end

  def current_user
    user_id = session[:user_id]
    User.find(user_id) if user_id
  end
end
