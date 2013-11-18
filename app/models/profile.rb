class Profile < ActiveRecord::Base
  include Slugs
  resourcify
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :middle_name, presence: { allow_nil: true, allow_blank: true }

  belongs_to :user
  mount_uploader :avatar, AvatarUploader

  def slug_candidates
    [
      :first_name,
      [:first_name, :last_name],
      [:first_name, :middle_name, :last_name]
    ]
  end
end
