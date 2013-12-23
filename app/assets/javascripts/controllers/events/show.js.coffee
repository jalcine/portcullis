#= require controllers/events

Portcullis.Events.Show =
  map: null
  init : ->
    self.loadBannerImage()
    self.renderEventMap()
    setTimeout ->
      $('#event_banner_actions').fadeIn()
    , 3750
  loadBannerImage: ->
    banner = $('#event_banner_content')
    banner.css 'background-image', "url(#{banner.attr('data-event-banner')})"
    banner.removeAttr 'data-event-banner'
  renderEventMap: ->

self = Portcullis.Events.Show

Portcullis.bind 'boot', ->
  Portcullis.Events.Show.init() if $('body').hasClass 'show'
