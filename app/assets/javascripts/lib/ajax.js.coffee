#= require jquery_ujs

$.rails.ajax = (options) ->
  # TODO: Do catching of errors.
  $.ajax options
