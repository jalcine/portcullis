class Transaction < ActiveRecord::Base
  has_many :orders
  belongs_to :merchant, class_name: User, foreign_key: :merchant_id
  after_save :readonly!, if: -> { braintree_transaction_id.present? }

  def authorize!
    return if authorized?
    # TODO Collect payment information from the user's Braintree backend.
    customer = user.to_customer
    true
  end

  def settle!
    result = Braintree::Transaction.submit_for_settlement(braintree_transaction_id)
    return true if result.success?
    raise NoMethodError, result.errors.to_s
  end

  def service_fee
    braintree_transaction.service_fee
  end

  def authorized?
    return false unless readonly?
    braintree_transaction.status == 'authorized'
  end

  def settled?
    return false unless readonly?
    puts ap(braintree_transaction)
    braintree_transaction.status == 'settled'
  end

  def declined?
    return false unless readonly?
    braintree_transaction.status == 'declined'
  end

  def amount
    braintree_transaction.amount
  end

  private
  def braintree_transaction
    return nil if braintree_transaction_id.nil?
    result = Braintree::Transaction.find(braintree_transaction_id)
    result
  end
end
