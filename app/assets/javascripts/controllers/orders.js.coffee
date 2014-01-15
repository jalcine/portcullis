#= require lib/core
# TODO Use Backbone.Model for orders
# TODO Use Backbone.Views to handle views

Portcullis.Orders =
  validateOrders: () ->
    tickets = $('ul.ticket-list').find('li.ticket')
    count = 0
    tickets.each (index, ticket) =>
      ticket = $(ticket)
      if Portcullis.Tickets.validateTicket(ticket)
        count++
    count != 0

  submitOrders: () ->
    orderParams = self.collectOrders()

  collectOrders: () ->
    tickets = $('ul.ticket-list').find('li.ticket')
    orders = {
      tickets: []
      event_id: $('ul.ticket-list').attr('data-event')
    }
    tickets.each (index, ticket) =>
      ticket = $(ticket)
      time_range = Portcullis.Tickets.obtainTimeRange(ticket)
      if time_range.is_current
        orders.tickets[orders.tickets.length] =
          id: ticket.attr('data-ticket-id')
          number: parseInt(ticket.find('input[data-ticket=quantity]').val())
    orders

self = Portcullis.Orders
