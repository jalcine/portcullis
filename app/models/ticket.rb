class Ticket < ActiveRecord::Base
  resourcify
  belongs_to :event, inverse_of: :tickets

  def is_free?
    price == 0
  end
    
  def to_builder
    Jbuilder.new do | ticket |
      ticket.(self, :name, :description, :price, :quantity, :event)
    end
  end
end
