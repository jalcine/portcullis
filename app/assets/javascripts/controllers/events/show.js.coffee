#= require controllers/events

Portcullis.Events.Show =
  map: null
  current: null
  tickets: []
  ticketViews: []
  init : ->
    self.loadBannerImage()
    event_id = $('#event_banner_content').attr('data-event-id')
    self.current = new Portcullis.Models.Event {id: event_id}
    self.current.on 'change:tickets', (event, tickets) ->
      self.collectTickets tickets
    self.current.fetch()
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
    header.css 'background-image', "url(#{banner.attr('data-event-banner')})"

self = Portcullis.Events.Show

Portcullis.bind 'boot', ->
  Portcullis.Events.Show.init() if $('body').hasClass 'show'
