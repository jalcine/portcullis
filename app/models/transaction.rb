class Transaction < ActiveRecord::Base
  has_many :orders
  belongs_to :merchant, class_name: User, foreign_key: :merchant_id
  after_save :readonly!, if: -> { braintree_transaction_id.present? }

  def authorize!
    return if authorized?
    result = Braintree::Transaction.sale(
      amount: 100.00,
      credit_card: {
        number: 4444444444444448,
        expiration_date: "05/14"
      }
    ) 

    if result.success?
      write_attribute(:braintree_transaction_id, result.transaction.id)
      save!
    else
      raise NoMethodError, result.errors.to_s
    end

    result.success?
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
