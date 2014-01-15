class Transaction < ActiveRecord::Base
  has_many :orders
  belongs_to :merchant, class_name: User, foreign_key: :merchant_id
  before_save :only_one_paying_user
  after_save :readonly!, if: -> { braintree_transaction_id.present? }

  public
  def authorize!
    return if authorized?
  end

  def settle!
    result = Braintree::Transaction.submit_for_settlement(braintree_transaction_id)
    return true if result.success?
    raise NoMethodError, result.errors.to_s
  end

  def service_fee
    bt = braintree_transaction
    bt.nil? ? -1 : bt.service_fee
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
    bt = braintree_transaction
    bt.nil? ? -1 : bt.amount
  end

  private
  def braintree_transaction
    return nil if braintree_transaction_id.nil?
    result = Braintree::Transaction.find(braintree_transaction_id)
    result
  end

  def only_one_paying_user
    users = orders.select(:user_id)
    users.length == 1 or users.length == 0
  end
end
