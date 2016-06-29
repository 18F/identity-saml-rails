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

  def failure
    flash[:alert] = t('omniauth_callbacks.failure', reason: failure_message)
    redirect_to failure_url
  end

  private

  def failure_message
    env['omniauth.error.type'].to_s.humanize
  end
end
