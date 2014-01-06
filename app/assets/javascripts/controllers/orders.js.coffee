#= require lib/core

Portcullis.Orders =
  bind: ->
    # TODO: Link a[data-order=checkout] buttons to handle purchase.
    self.bindElements()

  validateOrder: (button) ->
    tickets = $(button.siblings('ul.ticket-list').find('li.ticket'))
    count = 0
    tickets.each (index, ticket) =>
      ticket = $(ticket)
      if Portcullis.Tickets.validateTicket(ticket)
        count++

    console.log count, tickets.length
    count == tickets.length && count != 0

  submitOrder: (button) ->
    tickets = $(button.siblings('ul.ticket-list').find('li.ticket'))
    console.log tickets

  bindElements: ->
    $('ul.ticket-list + a[data-order=checkout]').on 'click', =>
      self.submitOrder $(@) if self.validateOrder $(@)

self = Portcullis.Orders

Portcullis.bind 'boot', ->
  Portcullis.Orders.bind()
