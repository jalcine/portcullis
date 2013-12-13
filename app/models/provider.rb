class Provider < ActiveRecord::Base
  resourcify
  belongs_to :user
  validates :token,  uniqueness: true, presence: true
  validates :user,   presence: { message: 'referencing user is required.' }
  validates :uid,    presence: { message: 'authentication service user ID is required.' }

  public
  def import_from_oauth(provider, oauth_data)
    profile = self.user.create_profile
    case provider.to_sym
    when :facebook
      profile.first_name = oauth_data['first_name']
      profile.last_name = oauth_data['first_name']
    when :gplus
      profile.first_name = oauth_data['first_name']
      profile.last_name = oauth_data['first_name']
    when :linkedin
      profile.first_name = oauth_data['first_name']
      profile.last_name = oauth_data['last_name']
    end
    profile.save!
    user.save!
  end
end
