#= require underscore
#= require backbone
#= require jquery/picker
#= require jquery/picker.date
#= require jquery/picker.time
#= require jquery/number.min
# This is where the skeleton of Portcullis is supposed to happen. Like don't fuck
# with this. I'll find you. Seriously, most of the core JavaScript things like
# Backbone and Underscore would be found here.

window.Portcullis =
  Models : {}
  Views : {}
  Collections : {}
  boot : ->
    Portcullis.bindElements $(document.body)
    Portcullis.trigger 'boot'
    Portcullis.boot = null
  bindElements: (base) ->
    return if base is undefined
    base.find('input[type=date]').pickadate()
    base.find('input[type=time]').pickatime()
    base.find('input[type=number], .number').number(true, 2)

    $(document).on 'opened', '[data-reveal]', =>
      console.log @
      Portcullis.bindElements $(@)

_.extend Portcullis, Backbone.Events
_.once Portcullis.boot

# This should always only happen on the DOM load. So it'd only run on a clean
# slate.
$(window).on 'load', =>
  Portcullis.boot()
