#= require jquery_ujs
#= require rails-timeago-all
#= require foundation
#= require jquery/number.min
#= require_tree ./lib
#= require_tree ./controllers

# Force timeago to publish times in a future tense (nearly all of them will be
# anyways.
jQuery.timeago.settings.allowFuture = true

$ ->
  doc = $ document
  doc.foundation()
  setTimeout ->
    $('.alert-box').fadeOut()
  , 3000
