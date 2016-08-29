class HomeController < ApplicationController
  def index
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
