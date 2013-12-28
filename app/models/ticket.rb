class Ticket < ActiveRecord::Base
  resourcify
  has_paper_trail
  belongs_to :event, inverse_of: :tickets

  public
    def is_free?
      price == 0
    end

    def expired?
      return true if event.expired?
      return true if Time.now > date_end
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
end
