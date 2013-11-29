class ApplicationController < ActionController::Base
  # Ensure CanCan logic is employed.
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_out_path_for(resource)
    root_url
  end

  def after_sign_in_path_for(resource)
    #view_user_dashboard_path 
    root_url
  end

  def user_for_paper_trail
    user_signed_in? ? current_user : User.new
  end
end
