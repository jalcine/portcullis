class Order < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :transaction
  belongs_to :paying_user, class_name: User, foreign_key: :paying_user_id

  validates_presence_of :ticket
  validates_presence_of :user
  validates_presence_of :charge
  validates_presence_of :paying_user, message: 'must be present to handle the charge'
  validates_numericality_of :charge, if: -> { ticket.donation? }

  before_save :validate_charge

  public
  def charge=(new_charge)
    new_charge = 0 if ticket.free?
    write_attribute(:charge, new_charge)
  end

  public
  def service_fee
    if ticket.free? then
      return 0
    elsif ticket.priced?
      return ticket.service_fee
    elsif ticket.donation?
      fee = charge * 0.025 + 99
      fee = 995 if fee > 995
      return fee
    end
  end

  private
  def validate_charge
    if charge.zero? and ticket.priced? then
      charge = ticket.price + ticket.service_fee
    end
  end
end
