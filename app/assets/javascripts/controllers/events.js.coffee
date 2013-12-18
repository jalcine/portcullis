#= require lib/core
#= require jquery/picker
#= require jquery/picker.date
#= require jquery/picker.time
#= require leaflet/leaflet
#= require leaflet/l.control.locate.js
#= require leaflet/l.control.geosearch.js
#= require leaflet/l.geosearch.provider.openstreetmap.js

Portcullis.Events =
  init: ->

Portcullis.bind 'boot', ->
  Portcullis.Events.init() if $('body').hasClass 'events'
