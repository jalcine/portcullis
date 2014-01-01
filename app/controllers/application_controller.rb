class ApplicationController < ActionController::Base
  # If enabled, handle Vanity testing.
  #use_vanity :current_user

  # Include logic to pick up browser information.
  extend Browser::ActionController

  # Ensure CanCan logic is employed.
  rescue_from CanCan::AccessDenied do |exception|
    message = 'You aren\'t authorized to invoke that action.' 
    respond_to do | format |
      format.html { redirect_to root_url, alert: message }
      format.json { render json: message, status: :forbidden }
      format.js   { render json: message, status: :forbidden }
    end
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_out_path_for(resource)
    root_url
  end

  def after_sign_in_path_for(resource)
    request.referrer if request.referrer.present?
    events_url(scope: :recommended)
  end

  def user_for_paper_trail
    user_signed_in? ? current_user : User.new
  end
end
