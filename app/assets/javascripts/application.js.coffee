#= require jquery_ujs
#= require jquery/fitText
#= require jquery/number.min
#= require rails-timeago
#= require foundation
#= require count_up
#= require_tree ./lib
#= require_tree ../templates
#= require_tree ./controllers
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

# Force timeago to publish times in a future tense (nearly all of them will be
# anyways, so why not?)
jQuery.timeago.settings.allowFuture = true

$(window).load ->
  doc = $ document
  doc.foundation
    tooltips:
      selector: '.has-tip, *[data-tooltip]'
    topbar:
      is_hover: true
      mobile_show_parent_link: true
  $('.fit-text').fitText(0.7, minFontSize: '1rem')
  $('[data-countup-start]').each (index, rawElem) ->
    elem = $(rawElem)
    numAnim = new countUp(rawElem, elem.attr('data-countup-start'), elem.attr('data-countup-end'), elem.attr('data-countup-places'), elem.attr('data-countup-speed'))
    numAnim.start()
