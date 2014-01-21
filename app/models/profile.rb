class Profile < ActiveRecord::Base
  include Slugs
  resourcify
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :middle_name, presence: { allow_nil: true, allow_blank: true }
  after_save :update_braintree_customer, unless: :new_record?

  belongs_to :user
  mount_uploader :avatar, AvatarUploader

  private
  def slug_candidates
    [
      :first_name,
      [:first_name, :last_name],
      [:first_name, :middle_name, :last_name]
    ]
  end

  public
  def update_braintree_customer
    return if user.nil? or user.new_record?
    hash_of_properties = {}
    [:first_name, :last_name].each do | field |
      hash_of_properties[field] = read_attribute(field)
    end

    begin
      result = Braintree::Customer.update(user.read_attribute(:braintree_customer_id), hash_of_properties)
    rescue Braintree::NotFoundError
      Rails.logger.warn "No Braintree information found for profile ##{self.id}."
    rescue Braintree::UnexpectedError
      Rails.logger.warn "Unable to update Braintree user information for profile ##{self.id}."
    end
  end
end
