Portcullis.Tickets.New =
  bind: ->
    self.bindSalesWindow()
    self.bindPricingType()
    self.bindSubmission()

  injectNewEntry: (jsonData) ->
    # TODO: Inject the JAZZ NEGRO
    console.log 'dip mofo'
    console.log jsonData

  bindSubmission: ->
    $('form#new_ticket').on 'ajax:beforeSend', ->
      # TODO: Fix fields

    $('form#new_ticket').on 'ajax:success', (data, status, xhr) =>
      console.log data 
      self.injectNewEntry data

  bindPricingType: ->
    $('input[type=number]').number(true, 2)
    buttonPriceFree     = $ '#price_free'
    buttonPriceDonation = $ '#price_donation'
    buttonPriceFixed    = $ '#price_fixed'

    enableButton = (element) =>
      element = $(element)
      element.attr 'data-checked', 'true'
      element.find('i.fa').addClass('fa-check-circle')
    
    disableButtons = =>
      $('#pricing > li > span[data-checked]').each (index, element) ->
        element = $(element)
        element.removeAttr 'data-checked'
        element.find('i.fa').removeClass('fa-check-circle')

    buttonPriceFree.click (e) ->
      $('#pricer').slideUp()
      $('input#ticket_payment_type').val('free')

    buttonPriceFixed.click ->
      $('#pricer').slideDown()
      $('input#ticket_payment_type').val('fixed')

    buttonPriceDonation.click ->
      $('#pricer').slideDown()
      $('input#ticket_payment_type').val('donation')
      
    $('#pricing > li > span').click (e) =>
      disableButtons()
      setTimeout( () =>
        enableButton(e.target)
      , 200)

    buttonPriceFree.click()

  bindSalesWindow: ->
    console.log $('input#start_day').val()
    ticketDayStart = $('#ticket_day_start').pickadate().pickadate('picker')
    ticketTimeStart = $('#ticket_time_start').pickatime().pickatime('picker')
    ticketDayEnd = $('#ticket_day_end').pickadate().pickadate('picker')
    ticketTimeEnd = $('#ticket_time_end').pickatime().pickatime('picker')
    ticketDayStart.set('select', $('input#start_day').pickadate().pickadate('picker').get('select'))
    ticketTimeStart.set('select', $('input#start_time').pickatime().pickatime('picker').get('select'))
    ticketDayEnd.set('select', $('input#end_day').pickadate().pickadate('picker').get('select'))
    ticketTimeEnd.set('select', $('input#end_time').pickatime().pickatime('picker').get('select'))

self = Portcullis.Tickets.New

Portcullis.bind 'boot', ->
  Portcullis.Tickets.New.bind() if $('form#new_event').length isnt 0
