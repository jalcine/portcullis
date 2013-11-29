class Ticket < ActiveRecord::Base
  belongs_to :event, inverse_of: :tickets

  def is_free?
    price == 0
  end
end
