class Transaction < ActiveRecord::Base
  has_many :orders
  belongs_to :merchant, class_name: User, foreign_key: :merchant_id
  belongs_to :paying_user, class_name: User, foreign_key: :paying_user_id
  before_save :at_least_one_order
  after_save :only_one_paying_user, unless: -> { orders.empty? }

  public
  def authorize!
    return false if authorized?
    paying_user = orders.first.paying_user
    customer = paying_user.to_customer

    total_price = 0
    prices = orders.map { |o| o.charge }
    prices.each { |p| total_price += p }

    result = Braintree::Transaction.sale(
      amount: (total_price.to_f / 100).to_f,
      customer: {
        id: customer.id
      }
    )

    if result.success?
      write_attribute(:braintree_transaction_id, result.transaction.id)
      save!
      readonly!
    else
      raise StandardError, "Couldn't handle transaction."
      return false
    end

    true
  end

  def settle!
    return false unless authorized?
    result = Braintree::Transaction.submit_for_settlement(braintree_transaction_id)
    raise StandardError unless result.success?
    true
  end

  def charged_amount
    return -1 unless readonly?
    to_braintree.amount
  end

  def charged_service_fee
    return -1 unless readonly?
    to_braintree.service_fee
  end

  def authorized?
    return false unless readonly?
    to_braintree.status == 'authorized'
  end

  def settled?
    return false unless authorized? 
    to_braintree.status == 'settled'
  end

  def declined?
    return false unless authorized?
    to_braintree.status == 'declined'
  end

  private
  def to_braintree
    return nil unless readonly?
    result = Braintree::Transaction.find(braintree_transaction_id)
    return result
  end

  def at_least_one_order
    orders.length >= 1
  end

  def only_one_paying_user
    users = orders.select(:paying_user_id).distinct
    users.length == 1 or users.length == 0
  end
end
