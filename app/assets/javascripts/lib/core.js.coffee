#= require underscore
#= require backbone
# This is where the skeleton of Portcullis is supposed to happen. Like don't fuck
# with this. I'll find you. Seriously, most of the core JavaScript things like
# Backbone and Underscore would be found here.

if window.Portcullis is undefined
  Portcullis =
    boot : ->
      console.debug '[MELODY] Booted for first-run.'
      Portcullis.trigger 'boot'
      Portcullis.boot = null

  _.extend Portcullis, Backbone.Events
  _.once Portcullis.boot

  window.Portcullis = Portcullis

  # This should always only happen on the DOM load. So it'd only run on a clean
  # slate.
  $(window).on 'load', =>
    Portcullis.boot()
