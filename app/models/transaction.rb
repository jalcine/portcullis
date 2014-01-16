class Transaction < ActiveRecord::Base
  has_many :orders
  belongs_to :merchant, class_name: User, foreign_key: :merchant_id
  before_save :at_least_one_order
  after_save :only_one_paying_user, unless: -> { orders.empty? }
  after_save :readonly!, if: -> { braintree_transaction_id.present? }

  public
  def authorize!
    return if authorized?
    braintree_transaction_id = Random.rand(300)
  end

  def settle!
    result = Braintree::Transaction.submit_for_settlement(braintree_transaction_id)
    return true if result.success?
    raise NoMethodError, result.errors.to_s
  end

  def service_fee
    bt = braintree_transaction
    return (bt.nil? ? -1 : bt.service_fee)
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
    return (bt.nil? ? -1 : bt.amount)
  end

  private
  def braintree_transaction
    return nil if braintree_transaction_id.nil?
    result = Braintree::Transaction.find(braintree_transaction_id)
    result
  end

  def at_least_one_order
    orders.length >= 1
  end

  def only_one_paying_user
    users = orders.select(:paying_user_id)
    puts ap(users)
    users.length == 1 or users.length == 0
  end
end
