module TicketsHelper
  def purchased_ticket?(ticket)
    user_signed_in? ? ticket.purchased?(current_user) : false
  end

  def ticket_classes(ticket)
    class_string = ""
    class_string += 'current' if ticket.available?
    class_string += 'past' if ticket.expired?
    class_string += 'future' if !ticket.expired? and !ticket.available?
  end
end
