#= require controllers/tickets
# TODO: Add logic for unlimited ticket sales.
Portcullis.Tickets.New =
  elems:
    buttons:
      priceFull: null
      priceFixed: null
      priceDonation: null
    price: null
    date:
      day_start: null
      day_end: null
      time_start: null
      time_end: null
  bind: ->
    self.bindSubmission()
    self.bindSalesWindow()
    self.bindPricingType()

  injectNewEntry: (jsonData) ->
    console.log jsonData

  bindElements : ->
    self.elems.price = $('input#ticket_price')
    self.elems.buttons.priceFree = $ '#price_free'
    self.elems.buttons.priceDonation = $ '#price_donation'
    self.elems.buttons.priceFixed = $ '#price_fixed'
    self.elems.date.day_start = $ '#ticket_day_start'
    self.elems.date.day_end   = $ '#ticket_day_end'
    self.elems.date.time_start = $ '#ticket_time_start'
    self.elems.date.time_end   = $ '#ticket_time_end'

  synchronization: ->
    updatePrice: ->
      thePrice = self.elems.price.val()
      thePrice *= -1 if thePrice < 0
      thePrice *= -1 if $('span#price_donation[data-checked]').length isnt 0
      thePrice = 0   if $('span#price_free[data-checked]').length isnt 0
      self.elems.price.val thePrice
    updateDate : ->
      date_start = $('input[type=hidden]#ticket_date_start')
      date_end = $('input[type=hidden]#ticket_date_start')
      date_start.val(ticketDayStart.get('select') + ticketTimeStart.get('select'))
      date_end.val(ticketDayEnd.get('select') + ticketTimeEnd.get('select'))
      console.debug date_start.val()

  bindSubmission: ->
    $('form#new_ticket').on 'ajax:before', ->
      self.synchronization.updatePrice()
      self.synchronization.updateDate()

    $('form#new_ticket').on 'ajax:complete', (event, data, status, xhr) =>
      if status is 'error'
        alert xhr.responseText
      else if status is 'success'
        $('#modal_add_ticket').foundation('reveal', 'close')
        self.injectNewEntry data 

  bindPricingType: ->
    $('input[type=number]').number(true, 2)

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

    self.elemes.buttons.priceFree.click()

  bindSalesWindow: ->
    ticketDayStart = self.elems.date.day_start.pickadate().pickadate('picker')
    ticketTimeStart = $self.elems.date.day_end.pickatime().pickatime('picker')
    ticketDayEnd = self.elems.date.time_start.pickadate().pickadate('picker')
    ticketTimeEnd = self.elems.date.time_end.pickatime().pickatime('picker')
    ticketDayEnd.set('select', new Date())
    ticketTimeEnd.set('select', new Date())
    ticketDayStart.set('select', $('input#start_day').pickadate().pickadate('picker').get('select'))
    ticketTimeStart.set('select', $('input#start_time').pickatime().pickatime('picker').get('select'))

self = Portcullis.Tickets.New

Portcullis.bind 'boot', ->
  Portcullis.Tickets.New.bind() if $('form#new_event').length isnt 0
