#= require jquery/picker
#= require jquery/picker.date
#= require jquery/picker.time
#= require jquery/picker.legacy
#= require lib/core

Portcullis.Events =
  init: ->

Portcullis.bind 'boot', ->
  Portcullis.Events.init()
