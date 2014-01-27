#= require controllers/events

Portcullis.Events.Show =
  map: null
  current: null
  tickets: []
  ticketViews: []

  init : ->
    event_id = $('#event_banner_content').attr('data-event-id')
    self.current = new Portcullis.Models.Event {id: event_id}
    self.current.on 'change:tickets', (event, tickets) ->
      self.collectTickets tickets
    self.current.fetch()
    $('button#order_tickets').bind 'click', ->
      self.invokeOrderDialog
    self.loadBannerImage()

  invokeOrderDialog : () ->
    orders = new Portcullis.Collections.Orders()
    for ticketView in self.ticketViews
      do (ticketView) ->
        return unless ticketView.isAvailable()
        aOrder = null
        attrs =
          ticket:   ticketView.model
          quantity: ticketView.providedQuantity()
        aOrder = new Portcullis.Models.Order attrs
        orders.add aOrder
    (new Portcullis.Views.OrdersIndex({orders: orders})).showModal()

  collectTickets: (ticketIds) ->
    for ticketId in ticketIds
      do (ticketId) ->
        ticket = new Portcullis.Models.Ticket {id: ticketId}
        view = new Portcullis.Views.TicketsShow {model: ticket}
        ticket.on 'change', () =>
          view.render()
        ticket.fetch()
        self.tickets[self.tickets.length] = ticket
        self.ticketViews[self.ticketViews.length] = view 

  loadBannerImage: ->
    banner = $('#event_banner_content')
    header = $('#event_banner')
    banner_url = banner.attr 'data-event-banner'
    header.css 'background-image', "url(#{banner_url})"

self = Portcullis.Events.Show

Portcullis.bind 'boot', ->
  Portcullis.Events.Show.init() if $('body').hasClass 'show'
