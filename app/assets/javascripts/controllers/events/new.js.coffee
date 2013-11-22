Portcullis.Events.New =
  leaflet:
    handle: null
    address:
      box: $ '#event_address'
      tool:
        title:   $ '#event_address_title'
        address: $ '#event_address_line'
        city:    $ '#event_address_city'
        state:   $ '#event_address_state'
        zipcode: $ '#event_address_zipcode'
    search:
      timeout: 0
      polygon: null
      fromAddressTool: =>
        query = "#{@leaflet.address.tool.title.val()},  " +
          "#{@leaflet.address.tool.line.val()},  " +
          "#{@leaflet.address.tool.city.val()},  " +
          "#{@leaflet.address.tool.state.val()}  " +
          "#{@leaflet.address.tool.zipcode.val()}"
        @discoverFromQuery query
    controls:
      locate: null
    layers:
      search: null
    map:
      elem: $ '#eventMap'
      toggle: =>
        addressTool = $ '#event_address_tool'
        addressBar  = $ '#event_address'
        visible     = $('#event_address_tool:visible').length is 1

        if visible
          addressBar.removeAttr 'disabled'
        else
          addressBar.attr 'disabled', 'disabled'

        addressTool.slideToggle =>
          @leaflet.handle.invalidateSize true
      render: =>
        theForm = @leaflet.map.elem.prev()
        @leaflet.map.elem.css
          height: theForm.height()
          width:  theForm.width()
        @leaflet.handle = L.map('event_map', {
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
        @fillInAddressTool()
        @leaflet.handle.on 'locationfound', (le) =>
          @discoverFromCoords le.latitude, le.longitude, =>
            console.log @leaflet.address.box.data 'geodata'
            @fillInAddressTool()
        @leaflet.controls.locate = L.control.locate({
          position: 'bottomright'
          locateOptions:
            maxZoom: 20
            setView: true
            animate: true
            reset: false
        }).addTo @leaflet.handle
  setMarker: (lat, lng = nil) ->
    if typeof lat is Array and !lng?
      _z = lat
      lat = _z[0]
      lng = _z[1]
    @leaflet.handle.setView [lat, lng]
  fillInAddressTool: ->
    data = @leaflet.address.box.data 'geodata'
    if data isnt undefined
      @leaflet.address.tool.line.val "#{data['address']['road'] || data['address']['pedestrian']}"
      @leaflet.address.tool.line.val "#{data['address']['house_number']} " + @leaflet.address.tool.line.val() if data['type'] == 'house'
      @leaflet.address.tool.city.val data['address']['county'] || data['address']['state_district'] || data['address']['city']
      @leaflet.address.tool.state.val data['address']['state']
      @leaflet.address.tool.zipcode.val data['address']['postcode']
      @leaflet.address.tool.title.val "#{data['address'][data['type']] }" if data['address'][data['type']]?
      @leaflet.address.box.val "#{@leaflet.address.tool.line.val()}, #{@leaflet.address.tool.city.val()}, #{@leaflet.address.tool.state.val()} #{@leaflet.address.tool.zipcode.val()}"
  discoverFromCoords: (lat, lng, callback = null) ->
    provider = new L.GeoSearch.Provider.OpenStreetMap()
    provider.options.zoom = 18
    provider.options.addressdetails = 1
    provider.options.countrycodes = ['us']
    provider.options.limit = 1
    provider.options.polygon = 1
    url = provider.GetReverseServiceUrl lat, lng
    @handleQueryURI url, false, callback
  discoverFromQuery: (query, callback) ->
    provider = new L.GeoSearch.Provider.OpenStreetMap()
    provider.options.zoom = 18
    provider.options.addressdetails = 1
    provider.options.countrycodes = ['us']
    provider.options.limit = 1
    provider.options.polygon = 1
    url = provider.GetServiceUrl query, true
    @handleQueryURI url, true, callback
  handleQueryURI: (url, moveToPlace = false, callback = null) ->
    $.getJSON url, {}, (d,t,j) =>
      result = d
      result = d[0] if d.length?
      callback.call() if callback?
      $('#event_full_address > i.fa').removeClass('fa-spinner fa-spin').addClass('fa-cross-hairs')
      @leaflet.address.box.removeData 'geodata'
      if result?
        @leaflet.address.box.data 'geodata', result
        @leaflet.address.box.val "#{result['address']['road']}"
        @leaflet.handle.panTo [result.lat, result.lon], { animate: true } if moveToPlace is true
        bounds = L.latLngBounds result['polygonpoints']
        if bounds?
          @leaflet.handle.removeLayer(@leaflet.layers.search) if @leafletLayers.search?
          @leaflet.layers.search = L.rectangle bounds, {color: '#ff7800', weight: 1}
          @leaflet.layers.search.addTo @leaflet.handle
  searchFromAddressBar: ->
  bindEvents : ->
    @bindDateTimeTools()
    @bindLocationTools()
  bindLocationTools: ->
    @leaflet.map.render()
    # Bind up the fields.
    $('a#event_full_address').click ->
      Portcullis.Events.New.map.toggle()

    $('input#event_address').keyup =>
      @searchFromAddressBar()

    $('#event_address_tool_fill').click (e) =>
      e.preventDefault()
      @fillInAddressTool()

    $('#event_address_title, #event_address_line,' +
      '#event_address_city, #event_address_state,' +
      '#event_address_zipcode').keyup =>
        console.log @leaflet.search.timeout
        clearTimeout @leaflet.search.timeout
        $('#event_full_address > i.fa').removeClass('fa-cross-hairs').addClass('fa-spinner fa-spin')
        @leaflet.search.timeout = setTimeout( () =>
          @leaflet.search.fromAddressTool()
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
            opened: ->
              $('form#new_event').addClass 'ghost'
            closed: ->
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
  Portcullis.Events.New.bindEvents() if $('body').hasClass('events new')
