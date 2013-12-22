#= require jquery_ujs
#= require rails-timeago-all
#= require foundation
#= require jquery/fitText
#= require jquery/number.min
#= require_tree ./lib
#= require_tree ./controllers

# Force timeago to publish times in a future tense (nearly all of them will be
# anyways.
jQuery.timeago.settings.allowFuture = true

$ ->
  doc = $ document
  doc.foundation {
    tooltips: {
      selector: '.has-tip, *[data-tooltip]'
    },
    topbar: {
      is_hover: false
      mobile_show_parent_link: true
    }
  }
  $('.fit-text').fitText(0.7, {
    minFontSize: '14px'
  })
  setTimeout ->
    $('.alert-box').fadeOut()
  , 3000
