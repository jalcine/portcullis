module TicketsHelper
  def purchased_ticket?(ticket)
    user_signed_in? ? ticket.purchased?(current_user) : false
  end
end
