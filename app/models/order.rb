class Order < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :transaction

  validates_presence_of :ticket
  validates_presence_of :user

  before_save :update_charge

  private
  def update_charge
    # The event holder may change the price in the future. However, whatever
    # the attendee paid should be the resulting price; nothing more.
    self.charge = ticket.price if ticket.price.nonzero? and charge.present?
  end
end
