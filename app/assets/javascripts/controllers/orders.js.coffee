#= require lib/core

Portcullis.Orders =
  bind: ->
    # TODO Link a[data-order=checkout] buttons to handle purchase.
    self.bindElements()

  validateOrder: (button) ->
    tickets = button.siblings('ul.ticket-list').find('li.ticket')
    count = 0
    tickets.each (index, ticket) =>
      ticket = $(ticket)
      if Portcullis.Tickets.validateTicket(ticket)
        count++

    count == tickets.length && count != 0

  submitOrder: (button) ->
    orderParams = collectOrder button
    console.log orderParams

  collectOrder: (button) ->
    tickets = $(button.siblings('ul.ticket-list').find('li.ticket'))
    orders = []
    tickets.each (index, ticket) =>
      ticket = $(ticket)
      time_range = Portcullis.Tickets.obtainTimeRange(ticket)
      if time_range.is_current
        orders[orders.length] =
          ticket: ticket.attr('data-ticket-id')
          number: parseInt(ticket.find('input[data-ticket=quantity]').val())
    orders


  bindElements: ->
    $('ul.ticket-list + a[data-order=checkout]').on 'click', ->
      self.submitOrder $(@) if self.validateOrder $(@)

self = Portcullis.Orders

Portcullis.bind 'boot', ->
  Portcullis.Orders.bind()
