#= require controllers/orders

Portcullis.Orders.Compose =
  compile: ->
    orders = Portcullis.Orders.collectOrders() 
    $('table#orders > tbody > tr:first-child').remove()
    for ticket in orders.tickets
      ticketElem = $('li[data-ticket-id=' + ticket.id + ']')
      ticketName = ticketElem.find('.titlebar > h2').attr('title')
      ticketPrice = parseFloat(ticketElem.find('.titlebar span.price').attr('data-price'))
      ticketQuantity = ticketElem.find('input[type=number]').val()
      tr = $('<tr>').appendTo('table#orders > tbody')
      tr.data 'order', ticket
      console.debug ticketPrice
      name = $('<td></td>').appendTo(tr).text(ticketName)
      price = $('<td></td>').appendTo(tr).html(ticketPrice)
      quantity = $('<td></td>').appendTo(tr).text(ticket.number)
      total = $('<td></td>').appendTo(tr).html(ticketPrice * ticket.number)

  bind: ->

Portcullis.bind 'boot', ->
  Portcullis.Orders.Compose.bind()
