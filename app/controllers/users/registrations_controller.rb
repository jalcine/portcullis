class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    profile = @user.build_profile first_name: params[:profile][:first_name],
      last_name: params[:profile][:last_name]
    profile.save!
  end
end
