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
      price == 0.0
    end

    def is_donation?
      price < 0
    end

    def is_priced?
      price > 0
    end

    def expired?
      return true if event.expired?
      date_end <= DateTime.now
    end

    def price=(value)
      value = value.to_i
      if value < -1
        value = -1
      end

      write_attribute(:price, value)
    end

    def available?
      return false if expired?
      time_now = Time.now
      time_now > date_start && time_now < date_end
    end

    def purchased?(user)
      !Order.includes(:tickets, :users).where(ticket: self, user: user).empty?
    end

    # TODO: Form transaction data for purchases of orders.
    def purchase_for(user)
      return nil if !available? or user.nil?
      order = Order.create ticket: self, user: user
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
