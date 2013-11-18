class HomeController < ApplicationController
  def landing
    redirect_to view_user_dashboard_url and return if user_signed_in?
    render 'home/index'
  end

  def about
  end

  def rescue_from_routing_error
    render status: :not_found, template: 'errors/500'
  end
end
