module Customer
  extend ActiveSupport::Concern

  included do
    after_create :connect_with_braintree
  end

  public
  def to_customer
    connect_with_braintree if braintree_customer_id.nil?
    return Braintree::Customer.search do | search |
      search.id.is braintree_customer_id
      search.email.is email
    end
  end

  private
  def connect_with_braintree
    result = Braintree::Customer.create
    write_attribute(:braintree_customer_id, result.customer.id) if result.success?
  end
end
