module Customer
  extend ActiveSupport::Concern

  included do
    after_create :connect_with_braintree
  end

  public
  def to_customer
    connect_with_braintree if braintree_customer_id.nil?
    result = Braintree::Customer.find(braintree_customer_id)
    result
  end

  protected
  def connect_with_braintree
    result = Braintree::Customer.create({
      email: self.email
    })
    self.profile.update_braintree_customer if self.profile.present?
    write_attribute(:braintree_customer_id, result.customer.id) if result.success?
  end
end
