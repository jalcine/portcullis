class Transaction < ActiveRecord::Base
  has_many :orders
  belongs_to :merchant, class_name: User, foreign_key: :merchant_id
  belongs_to :paying_user, class_name: User, foreign_key: :paying_user_id
  before_save :at_least_one_order
  after_save :only_one_paying_user, unless: -> { orders.empty? }

  def event
    orders.first.ticket.event
  end

  public
  def authorize!
    return false if authorized?
    self.paying_user = orders.first.paying_user

    charges = parse_fee_handling(calculate_charges)
    result = transact(charges)

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

  def calculate_charges
    total_price = 0
    total_service_fee = 0
    orders.each do |o|
      total_price += o.charge
      total_service_fee += o.service_fee
    end

    {
      price: total_price,
      service_fee: total_service_fee + (0.03 * total_price),
    }
  end

  def parse_fee_handling(charges)
    case event.fee_processing
      when Event::FEE_SPLIT
        charges[:price] += half
      when Event::FEE_PASS_ON
        charges[:price] += charges[:service_fee]
      when Event::FEE_TAKE_ON
        charges[:price] -= charges[:service_fee]
    end

    charges
  end

  def monetize_prices(charges)
    [:price, :service_fee].each { |f| charges[f] = (charges[f].to_f / 100).round(2) }
    charges
  end

  def transact(charges)
    charges = monetize_prices(charges)
    customer = self.paying_user.to_customer
    Braintree::Transaction.sale(
      merchant_account_id: Settings.braintree.merchant_account,
      amount: charges[:price],
      service_fee_amount: charges[:service_fee],
      customer: {
        id: customer.id
      },
      options: {
        submit_for_settlement: false,
        hold_in_escrow: true
      }
    )
  end

  def at_least_one_order
    orders.length >= 1
  end

  def only_one_paying_user
    users = orders.select(:paying_user_id).distinct
    users.length == 1 or users.length == 0
  end
end
