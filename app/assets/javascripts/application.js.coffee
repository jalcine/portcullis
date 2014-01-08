#= require jquery_ujs
#= require jquery/fitText
#= require jquery/number.min
#= require rails-timeago
#= require foundation
#= require_tree ./lib
#= require_tree ./controllers

# Force timeago to publish times in a future tense (nearly all of them will be
# anyways, so why not?)
jQuery.timeago.settings.allowFuture = true

$ ->
  doc = $ document
  doc.foundation
    tooltips:
      selector: '.has-tip, *[data-tooltip]'
    topbar:
      is_hover: false
      mobile_show_parent_link: true
    reveal:
      close_on_background_click: true
  $('.fit-text').fitText(0.7,
    minFontSize: '1rem'
  )
