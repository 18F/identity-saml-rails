class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  if Rails.env.production?
    http_basic_authenticate_with name: Rails.application.secrets.http_auth_username,
                                 password: Rails.application.secrets.http_auth_password
  end
end
