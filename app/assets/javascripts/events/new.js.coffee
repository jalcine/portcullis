#= require events

Portcullis.Events.New =
  bindEvents : ->
    # Bind up the fields.
    $('input[type=date]').pickadate()
    $('input[type=time]').pickatime()

    startDayElem = $('input#start_day')
    startTimeElem = $('input#start_time')
    endDayElem   = $('input#end_day')
    endTimeElem   = $('input#end_time')
    startDayPicker = startDayElem.pickadate('picker')
    startTimePicker = startTimeElem.pickatime('picker')
    endDayPicker   = endDayElem.pickadate('picker')
    endTimePicker   = endTimeElem.pickatime('picker')

    startDayPicker.on
      close: ->
        if startDayPicker.get('select').pick is 0
          startDayPicker.set 'select', Date.new

    endDayPicker.on
      close: ->
        startDayVal = startDayPicker.get('select').pick
        endDayVal = endDayPicker.get('select').pick
        if endDayVal is 0
          endDayPicker.set 'select', Date.new
          endDayVal = endDayPicker.get('select').pick

        if startDayVal > endDayVal
          endDayPicker.set 'select', startDayVal
          endDayElem.addClass 'error'
          endDayElem.parent().append '<small class="error">Specified date earlier than start date.</small>'
          endDayElem.blur()
        else
          endDayElem.removeClass 'error'
          endDayElem.parent().find('small.error').remove()

    endTimePicker.on
      close: ->
        startTimeVal = startTimePicker.get('select').pick
        endTimeVal = endTimePicker.get('select').pick
        startDayVal = startDayPicker.get('select').pick
        endDayVal = endDayPicker.get('select').pick

        sameDay = startDayVal == endDayVal

        if endDayVal + endTimeVal < startDayVal + startTimeVal
          endTimePicker.set 'select', startTimeVal
          endTimeElem.addClass 'error'
          endTimeElem.parent().append '<small class="error">Specified time earlier than start time.</small>'
          endTimeElem.blur()
        else
          endTimeElem.removeClass 'error'
          endTimeElem.parent().find('small.error').remove()

        console.log startTimeVal, endTimeVal, sameDay

        if sameDay and startTimeVal + 12 <= endTimeVal
          $('input#all_day').attr('checked', '')
          $('#modal_all_day').foundation('reveal', {
            closeOnBackgroundClick: true
            opened: () ->
              $('form#new_event').addClass 'ghost'
            closed: () ->
              $('form#new_event').removeClass 'ghost'
          }).foundation('reveal', 'open')

    
    # Rig the button.
    daForm = $('form#new_event')

    # Prepopulate fields.
    startDayPicker.set 'select', Date.new
    endDayPicker.set 'select', Date.new

    daForm.on 'submit', ->
      # TODO: Run validations.
      #
    $('#modal_all_day a.button').on 'click', ->
      $('#modal_all_day').foundation 'reveal', 'close'
    
    $('#modal_make_all_day').on 'click', ->
      $('input#all_day').attr('checked', true)

    $('input#all_day').on 'change', ->
      fields = $('input#end_time, input#start_time')
      val = $('input#all_day:checked').length is 1
      console.log val, fields

      if !val
        fields.removeAttr 'disabled'
      else
        fields.attr 'disabled', 'disabled'

Portcullis.bind 'boot', ->
  Portcullis.Events.New.bindEvents()
