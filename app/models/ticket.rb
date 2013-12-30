class Ticket < ActiveRecord::Base
  resourcify
  has_paper_trail
  belongs_to :event, inverse_of: :tickets

  validates_presence_of :date_start, message: 'must include a starting window'
  validates_presence_of :date_end, message: 'must include an ending window'
  validates_presence_of :name, message: 'must include a name for the ticket'
  validates_presence_of :price, message: 'must set a price'
  validates_numericality_of :price, message: 'must use a number for the price'

  public
    def is_free?
      price == 0
    end

    def is_donation?
      price * -1 != 0
    end

    def is_priced?
      price > 0
    end

    def expired?
      return true if Time.now > date_end
      return true if event.expired?
      false
    end

    def available?
      return false if expired?
      time_now = Time.now
      time_now > date_start && time_now < date_end
    end

    # TODO: Form transaction data for purchases of orders.
    def purchase_for(user)
      return nil if event.expired? or user.nil?
      transaction_data = {type: :credit}
      order = Order.new ticket: self, user: user
      order.begin_processing transaction_data
      order.save!

      order
    end

    def to_builder
      Jbuilder.new do | ticket |
        ticket.(self, :name, :description, :price, :quantity, :event)
      end
    end

  alias_method :priced?, :is_priced?
  alias_method :donation?, :is_donation?
  alias_method :free?, :is_free?
end
