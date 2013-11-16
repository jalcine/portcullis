$ ->
  $('header[role=page]').scrollspy
    min: 20
    max: $('header[role=page]').height() * 1.1,
    onEnter : (element, position) ->
      $('header[role=page]').removeClass 'compressed'
    onLeave : (element, position) ->
      $('header[role=page]').addClass 'compressed'
