#= require underscore
#= require backbone
# This is where the skeleton of Melody is supposed to happen. Like don't fuck
# with this. I'll find you. Seriously, most of the core JavaScript things like
# Backbone and Underscore would be found here.

if window.Melody is undefined
  Melody =
    boot : ->
      console.debug '[MELODY] Booted for first-run.'
      Melody.trigger 'boot'
      Melody.boot = null

  _.extend Melody, Backbone.Events
  _.once Melody.boot

  window.Melody = Melody

  # This should always only happen on the DOM load. So it'd only run on a clean
  # slate.
  $(window).on 'load', =>
    Melody.boot()
