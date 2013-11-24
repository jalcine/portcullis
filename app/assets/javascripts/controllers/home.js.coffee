$(window).one 'load', () ->
  if $('html.no-touch').length != 0
    video = $ '#video_bg > video:first-child'
   
    naturalVideoWidth = video.width()
    naturalVideoHeight = video.height()

    fitSmall = (width, height) ->
    
    fitBig = (width) ->

    fitNicely = () ->

    $(window).resize ->
      $('#video_caption').width($('body').width())
