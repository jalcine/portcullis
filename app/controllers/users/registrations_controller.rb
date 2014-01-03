class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    current_user.create_profile! first_name: params[:profile][:first_name],
      last_name: params[:profile][:last_name]
  end
end
