class AvatarUploader < ImageUploader
  def default_url
    # TODO: Define a sane default image.
    ActionController::Base.helpers.asset_path('users/default_avatar.png')
  end
end
