module Customer
  extend ActiveSupport::Concern

  included do
    after_create :connect_with_braintree
  end

  private
  def connect_with_braintree
    result = Braintree::Customer.create
    write_attribute(:braintree_customer_id, result.customer.id) if result.success?
  end
end
