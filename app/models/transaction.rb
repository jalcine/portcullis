class Transaction < ActiveRecord::Base
  has_many :orders
  belongs_to :merchant, class_name: User, foreign_key: :merchant_id
  after_save :readonly!

  def authorize!
  end

  def settle!
  end

  def service_fee
    braintree_transaction.service_fee
  end

  def authorized?
    braintree_transaction.status == :authorized
  end

  def settled?
    braintree_transaction.status == :settled
  end

  def amount
    braintree_transaction.amount
  end

  private
  def braintree_transaction
    Braintree::Transaction.find(self.braintree_transaction_id)
  end
end
