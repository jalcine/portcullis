class Order < ActiveRecord::Base
  unless defined?(ORDER_CANCELED)
    ORDER_PAYMENT_INITAITED = 0x010
    ORDER_PAYMENT_REFUSED   = 0x020
    ORDER_PAYMENT_PENDING   = 0x030
    ORDER_PAYMENT_ACCEPTED  = 0x040
    ORDER_CANCELED          = 0x800
    ORDER_COMPLETED         = 0x900
  end

  belongs_to :ticket
  belongs_to :user
  #has_one :transaction

  # TODO: Get orders for past events.
  # TODO: Get orders for future events.

  def processing?
    !(status == Order::ORDER_COMPLETED)
  end

  def paid?
    status == Order::ORDER_PAYMENT_ACCEPTED
  end

  def completed?
    status == Order::ORDER_COMPLETED
  end

  def begin_processing(transaction)
    # TODO: Build the transaction.
    # TODO: Pass this logic to be used with our payment libs.
    case transaction[:type]
    when :credit
    when :debit
    end
  end
end
