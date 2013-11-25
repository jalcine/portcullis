Portcullis.Events.New =
  timing:
    updateHidden: (time, date, hiddenField) ->
      resultingTime = time.pickatime('picker').get('select')
      resultingDate = date.pickadate('picker').get('select').obj
      dateTimeVal = resultingDate
      dateTimeVal.setHours resultingTime.hour
      dateTimeVal.setMinutes resultingTime.mins
      hiddenField.val dateTimeVal.toUTCString()
    updateHiddenStart: ->
      self.timing.updateHidden $('#start_time'), $('#start_day'), $('#event_date_start')
    updateHiddenEnd: ->
      self.timing.updateHidden $('#end_time'), $('#end_day'), $('#event_date_end')
  leaflet:
    handle: null
    address:
      box: $ '#event_address'
      list: $ '#event_address_list'
      tool:
        title:   $ '#event_address_title'
        address: $ '#event_address_line'
        city:    $ '#event_address_city'
        state:   $ '#event_address_state'
        zipcode: $ '#event_address_zipcode'
    controls:
      locate: null
    layers:
      search: null
    map:
      elem: $ '#eventMap'
      render: =>
        theForm = self.leaflet.map.elem.prev()
        self.leaflet.map.elem.css
          height: theForm.height()
          width:  theForm.width()
        self.leaflet.handle = L.map('event_map', {
          minZoom: 9
          maxZoom: 18
          zoom: 15
          center: { lat: 40.740083, lng: -73.9903489 }
          zoomControl: false
          attributionControl: false
          layers: [
            L.tileLayer('http://{s}.tile.cloudmade.com/ddac1a378966452591adc2782bf07771/997/256/{z}/{x}/{y}.png')
          ]
        })
        self.fillInAddressTool()
        self.leaflet.handle.on 'locationfound', (le) =>
          self.discover.fromCoords le.latitude, le.longitude, =>
            self.fillInAddressTool()
        self.leaflet.controls.locate = L.control.locate({
          position: 'bottomright'
          locateOptions:
            maxZoom: 20
            setView: true
            animate: true
            reset: false
        }).addTo self.leaflet.handle
  search:
    enableSpinner: ->
      $('#event_full_address > i.fa').removeClass('fa-cross-hairs').addClass('fa-spinner fa-spin')
    disableSpinner: ->
      $('#event_full_address > i.fa').removeClass('fa-spinner fa-spin').addClass('fa-cross-hairs')
    timeout: 0
    polygon: null
    fromAddressTool: =>
      query = self.leaflet.address.tool.title.val()
      query += self.leaflet.address.tool.address.val()
      query += self.leaflet.address.tool.city.val()
      query += self.leaflet.address.tool.state.val()
      query += self.leaflet.address.tool.zipcode.val()
      self.discover.fromQuery query, (result) ->
        return if !result?
        result = result[0] if typeof result is 'object'
        return if !result?
        self.leaflet.address.box.data 'geodata', result
        self.leaflet.address.box.val "#{result['address']['road']}"

    fromAddressBar: =>
      box = self.leaflet.address.box
      list = self.leaflet.address.list
      self.discover.fromQuery box.val(), (results) ->
        box.foundation 'dropdown', 'open'
        # TODO: Open/present droplist.
        # TODO: Populate list of options.
        # TODO: Bind each option to be filler.
  setMarker: (lat, lng = nil) ->
    if typeof lat is Array and !lng?
      _z = lat
      lat = _z[0]
      lng = _z[1]
    self.leaflet.handle.setView [lat, lng]
  fillInAddressTool: ->
    data = self.leaflet.address.box.data 'geodata'
    address = self.leaflet.address.tool
    if data?
      address.address.val "#{data['address']['road'] || data['address']['pedestrian']}"
      address.address.val "#{data['address']['house_number']} " + self.leaflet.address.tool.line.val() if data['type'] == 'house'
      address.city.val data['address']['county'] || data['address']['state_district'] || data['address']['city']
      address.state.val data['address']['state']
      address.zipcode.val data['address']['postcode']
      address.title.val "#{data['address'][data['type']] }" if data['address'][data['type']]?
      self.leaflet.address.box.val "#{address.title.val()}, #{address.address.val()}, #{address.city.val()}, #{address.state.val()} #{address.zipcode.val()}"
  discover:
    fromCoords: (lat, lng, callback = null) ->
      provider = new L.GeoSearch.Provider.OpenStreetMap()
      provider.options.zoom = 18
      provider.options.addressdetails = 1
      provider.options.countrycodes = ['us']
      provider.options.limit = 1
      provider.options.polygon = 1
      url = provider.GetReverseServiceUrl lat, lng
      self.discover.invokeQuery url, false, callback
    fromQuery: (query, callback) ->
      provider = new L.GeoSearch.Provider.OpenStreetMap()
      provider.options.zoom = 18
      provider.options.addressdetails = 1
      provider.options.countrycodes = ['us']
      provider.options.limit = 1
      provider.options.polygon = 1
      url = provider.GetServiceUrl query, true
      self.discover.invokeQuery url, true, callback
    invokeQuery: (url, moveToPlace = false, callback = null) ->
      self.search.enableSpinner()
      $.getJSON url, {}, (d,t,j) =>
        self.leaflet.address.box.removeData 'geodata'
        result = d
        result = d[0] if d.length?
        callback.call(self, d) if callback?
        self.search.disableSpinner()
        if result?
          self.leaflet.handle.panTo [result.lat, result.lon], { animate: true } if moveToPlace is true
          $('#event_longitude').val result.lat
          $('#event_latitude').val result.lon
          bounds = L.latLngBounds result['polygonpoints']
          if bounds?
            self.leaflet.handle.removeLayer(self.leaflet.layers.search) if self.leaflet.layers.search?
            self.leaflet.layers.search = L.rectangle bounds, {color: '#ff7800', weight: 1}
            self.leaflet.layers.search.addTo self.leaflet.handle
  form:
    pumpUpHiddenValues: ->
      dateStartElem = $('#event_date_start')
      dateEndElem = $('#event_date_end')
      startDayElem = $('input#start_day')
      startTimeElem = $('input#start_time')
      endDayElem   = $('input#end_day')
      endTimeElem   = $('input#end_time')
      startDayPicker = startDayElem.pickadate('picker')
      startTimePicker = startTimeElem.pickatime('picker')
      endDayPicker   = endDayElem.pickadate('picker')
      endTimePicker   = endTimeElem.pickatime('picker')
      dateStartElem.val (new Date(startDayPicker.get('select').pick + startTimePicker.get('select').pick * 1000)).toUTCString()
      dateEndElem.val (new Date(endDayPicker.get('select').pick + endTimePicker.get('select').pick * 1000)).toUTCString()
  bindEvents : ->
    @bindDateTimeTools()
    @bindLocationTools()

    # Bind the submission.
    $('form#new_event').submit (e) =>
      @form.pumpUpHiddenValues()
  bindLocationTools: ->
    self.leaflet.map.render()
    # Bind up the fields.

    $('input#event_address').keyup =>
      clearTimeout self.search.timeout
      self.search.timeout = setTimeout( () =>
        self.search.fromAddressBar()
      , 250)

    $('#event_address_tool_fill').click (e) =>
      e.preventDefault()
      self.fillInAddressTool()

    $('#event_address_title, #event_address_line,' +
      '#event_address_city, #event_address_state,' +
      '#event_address_zipcode').keyup =>
        clearTimeout self.search.timeout
        self.search.timeout = setTimeout( () =>
          self.search.fromAddressTool()
        , 250)
  bindDateTimeTools: ->
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
      set: ->
        self.timing.updateHiddenStart()

    startTimePicker.on
      set: ->
        self.timing.updateHiddenStart()
    
    endDayPicker.on
      set: ->
        self.timing.updateHiddenEnd()
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
      set: ->
        self.timing.updateHiddenEnd()
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

        if sameDay and startTimeVal + 12 <= endTimeVal
          $('input#all_day').attr('checked', '')
          $('#modal_all_day').foundation('reveal', {
            closeOnBackgroundClick: true
            opened: ->
              $('form#new_event').addClass 'ghost'
            closed: ->
              $('form#new_event').removeClass 'ghost'
          }).foundation('reveal', 'open')

    # Rig the button.
    daForm = $('form#new_event')

    # Prepopulate fields.
    startDayPicker.set 'select', new Date
    startTimePicker.set 'select', (new Date).getHours() * 60
    endDayPicker.set 'select', new Date
    endTimePicker.set 'select', (new Date).getHours() * 60
    $('#modal_all_day a.button').on 'click', ->
      $('#modal_all_day').foundation 'reveal', 'close'
    
    $('#modal_make_all_day').on 'click', ->
      $('input#all_day').attr('checked', true)

    $('input#all_day').on 'change', ->
      fields = $('input#end_time, input#start_time')
      val = $('input#all_day:checked').length is 1
      if !val
        fields.removeAttr 'disabled'
      else
        fields.attr 'disabled', 'disabled'

self = Portcullis.Events.New

Portcullis.bind 'boot', ->
  Portcullis.Events.New.bindEvents() if $('form#new_event').length isnt 0
