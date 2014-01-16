class Order < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :transaction
  belongs_to :paying_user, class_name: User, foreign_key: :paying_user_id

  validates_presence_of :ticket
  validates_presence_of :user
  validates_presence_of :charge
  validates_presence_of :paying_user_id, message: 'must be present to handle the charge'
  validates_numericality_of :charge

  before_save :update_charge
  before_save :validate_charge

  private
  def update_charge
    self.charge = ticket.price if ticket.priced? and charge.zero?
  end

  def validate_charge
    return false if charge.zero? and ticket.priced?
  end
end
