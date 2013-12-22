class Ticket < ActiveRecord::Base
  resourcify
  belongs_to :event, inverse_of: :tickets

  public
    def is_free?
      price == 0
    end

    def expired?
      return true if event.expired?
      return true if Time.now > date_end
    end

    def available?
      Time.now >= date_start && Time.now <= date_end
    end

    def purchase_for(user)
      # TODO: Form transaction data for purchases of orders.
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
