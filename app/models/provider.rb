class Provider < ActiveRecord::Base
  resourcify
  belongs_to :user
  validates :token,  uniqueness: true, presence: true
  validates :user,   presence: { message: 'referencing user is required.' }
  validates :uid,    presence: { message: 'authentication service user ID is required.' }

  public
  def import_from_oauth(oauth_data)
    attrs = {}

    case name.to_sym
    when :facebook
      attrs = {
        first_name: oauth_data['first_name'],
        last_name: oauth_data['first_name']
      }
    when :gplus
      attrs = {
        first_name: oauth_data['first_name'],
        last_name: oauth_data['first_name']
      }
    when :linkedin
      attrs = {
        first_name: oauth_data['first_name'],
        last_name: oauth_data['first_name']
      }
    end

    user.create_profile! attrs
  end
end
