class Ticket < ActiveRecord::Base
  belongs_to :event, inverse_of: :tickets

  public
    def is_free?
      price == 0
    end

    def expired?
      # TODO: Do check on ticket.
      event.expired?
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
