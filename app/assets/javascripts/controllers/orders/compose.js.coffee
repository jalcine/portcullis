#= require controllers/orders

Portcullis.Orders.Compose =
  compile: ->
    orders = Portcullis.Orders.collectOrders() 
    Portcullis.Orders.Compose.bind()
    $('table#orders > tbody > tr:first-child').remove()
    for ticket in orders.tickets
      # TODO Refactor the fuck outta this.
      alert ticket
      ticketElem = $('li[data-ticket-id=' + ticket.id + ']')
      ticketName = ticketElem.find('.titlebar > h2').attr('title')
      ticketPrice = parseFloat(ticketElem.find('.titlebar span.price').attr('data-price'))
      ticketPrice = 0 if isNaN(ticketPrice)
      ticketQuantity = parseFloat(ticketElem.find('input[type=number]').val())
      ticketQuantity = 0 if isNaN(ticketQuantity)
      tr = $('<tr>').appendTo('table#orders > tbody')
      tr.data 'order', ticket
      name = $('<td></td>').appendTo(tr).text(ticketName)
      price = $('<td></td>').appendTo(tr).html(ticketPrice)
      quantity = $('<td></td>').appendTo(tr).text(ticket.number)
      total = $('<td></td>').appendTo(tr).html(ticketPrice * ticket.number)

  bind: ->
    $('table#orders > tfoot td[colspan=3] a.button').on 'click', ->
      # TODO Refactor for submission using Backbone.

Portcullis.bind 'boot', ->
  Portcullis.Orders.Compose.bind()
