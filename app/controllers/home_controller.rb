class HomeController < ApplicationController
  def index
    @omniauth_request_url = build_omniauth_request_url
    session[:agency] = params[:agency]
    render_agency
  end

  def success
    render_agency
  end

  def failure
    render_agency
  end

  private

  def build_omniauth_request_url
    uri = URI.parse('/auth/saml')
    uri.query = { ial: ial }.to_query
    uri.to_s
  end

  def ial
    case params[:ial].to_i
    when 2
      2
    else
      1
    end
  end

  def render_agency
    return unless current_agency
    template = "agency/#{current_agency}/#{action_name}"
    try_render_template(template)
  end

  def try_render_template(template)
    render template, layout: false
  rescue ActionView::MissingTemplate => _err
    render file: "#{Rails.root}/public/404.html", status: 404
  rescue => err
    raise err # re-throw
  end

  def current_agency
    params[:agency] || session[:agency]
  end
end
