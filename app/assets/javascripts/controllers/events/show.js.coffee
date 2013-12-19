#= require controllers/events

Portcullis.Events.Show =
  map: null
  init : ->
    self.renderEventMap()
    setTimeout ->
      $('header#event_header').attr('data-expanded', 'collapsed')
    , 2000
    # TODO: Render a leaflet map.
  renderEventMap: ->
    coords = $('#event_map').data()
    self.map = L.map('event_map', {
      minZoom: 9
      maxZoom: 18
      zoom: 15
      center: { lat: coords.latitude, lng: coords.longitude }
      zoomControl: false
      attributionControl: false
      layers: [
        L.tileLayer('http://{s}.tile.cloudmade.com/ddac1a378966452591adc2782bf07771/997/256/{z}/{x}/{y}.png')
      ]
    })

self = Portcullis.Events.Show

Portcullis.bind 'boot', ->
  Portcullis.Events.Show.init() if $('body').hasClass 'show'
