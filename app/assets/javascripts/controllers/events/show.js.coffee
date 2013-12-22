#= require controllers/events

Portcullis.Events.Show =
  map: null
  init : ->
    self.renderEventMap()
    setTimeout ->
      $('#event_banner_actions').fadeIn()
    , 3750
  renderEventMap: ->

self = Portcullis.Events.Show

Portcullis.bind 'boot', ->
  Portcullis.Events.Show.init() if $('body').hasClass 'show'
