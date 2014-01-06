#= require lib/core

Portcullis.Tickets =
  bind: ->
    self.updateTicketClasses()

  validateTicket: (ticket) ->


  updateTicketClasses: ->
    tickets = $('li[data-ticket-id]')
    tickets.each (index, ticket) =>
      ticket = $(ticket)
      date_start = Date.parse(ticket.attr('data-ticket-start'))
      date_end = Date.parse(ticket.attr('data-ticket-end'))
      date_now = new Date
      is_in_future = date_start > date_now
      is_in_past = date_end < date_now
      is_current = date_start <= date_now && date_now >= date_end

      ticket.removeClass 'current past future'
      ticket.addClass 'current' if is_current
      ticket.addClass 'past' if is_in_past
      ticket.addClass 'future' if is_in_future


self = Portcullis.Tickets

Portcullis.bind 'boot', ->
  Portcullis.Tickets.bind()
