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
    self.bindElements()
    self.bindSubmission()
    self.bindSalesWindow()
    self.bindPricingType()

  handleErrors: (event, xhr, status) ->
    data = JSON.parse(xhr.responseText)
    elem = null

    getDateElem = (name) ->
      parentElem = $ ".row[data-ticket=#{name}]"
      parentElem.find 'input[type=text]'

    for key, value of data
      switch key
        when "date_start", "date_end"
          elem = getDateElem key
        else
          elem = $ "#ticket_#{key}"

      elem.addClass 'error'
      elem.after "<small class='error'>#{value}</small>"
      elem.one 'focus', -> =>
        elem.removeClass 'error'
        elem.find('+ small.error').remove()

  injectNewEntry: (jsonData) ->
    ticketList = $ '#event_ticket_list'
    ticketElem = $("li[data-ticket=#{jsonData.id}]")

    if ticketElem.length is 0
      ticketList.prepend jsonData.html
    else
      ticketElem.replaceWith jsonData.html

    $('form[data-ticket]').parent('[data-reveal]').foundation('reveal', 'close')

  bindElements : ->
    self.elems.price                 = $('input#ticket_price')
    self.elems.buttons.priceFree     = $ '#price_free'
    self.elems.buttons.priceDonation = $ '#price_donation'
    self.elems.buttons.priceFixed    = $ '#price_fixed'
    self.elems.date.day_start        = $ '#ticket_day_start'
    self.elems.date.day_end          = $ '#ticket_day_end'
    self.elems.date.time_start       = $ '#ticket_time_start'
    self.elems.date.time_end         = $ '#ticket_time_end'
    $('#ticket_description').tinymce()

  synchronization:
    updatePrice: ->
      thePrice = self.elems.price.val()
      thePrice *= -1 if thePrice < 0
      thePrice *= -1 if $('span#price_donation[data-checked]').length isnt 0
      thePrice = 0   if $('span#price_free[data-checked]').length isnt 0
      self.elems.price.val thePrice
    updateDate : ->
      ticketDayStart = self.elems.date.day_start.pickadate().pickadate('picker')
      ticketTimeStart = self.elems.date.time_start.pickatime().pickatime('picker')
      ticketDayEnd = self.elems.date.day_end.pickadate().pickadate('picker')
      ticketTimeEnd = self.elems.date.time_end.pickatime().pickatime('picker')
      date_start = $('input[type=hidden]#ticket_date_start')
      date_end = $('input[type=hidden]#ticket_date_end')
      date_start.val(new Date(ticketDayStart.get('select').pick + ticketTimeStart.get('select').pick))
      date_end.val(new Date(ticketDayEnd.get('select').pick + ticketTimeEnd.get('select').pick))

  bindSubmission: ->
    $('form[data-ticket]').on 'ajax:before', () ->
      $('form[data-ticket] small.error').remove()
      $('form[data-ticket] input.error').removeClass('error')
      self.synchronization.updatePrice()
      self.synchronization.updateDate()

    $('form[data-ticket]').on('ajax:error', (event, xhr, status) =>
      self.handleErrors event, xhr, status
    ).on('ajax:success', (event, data, status, xhr) =>
      self.injectNewEntry(data)
    )
  bindPricingType: ->
    $('#pricing > input[type=number]').number(true, 2)

    enableButton = (element) =>
      element = $(element)
      element.attr 'data-checked', 'true'
      element.find('i.fa').addClass('fa-check-circle')

    disableButtons = =>
      $('#pricing > li > span[data-checked]').each (index, element) ->
        element = $(element)
        element.removeAttr 'data-checked'
        element.find('i.fa').removeClass('fa-check-circle')

    self.elems.buttons.priceFree.click (e) ->
      $('#pricer').slideUp()
      $('input#ticket_payment_type').val('free')

    self.elems.buttons.priceFixed.click ->
      $('#pricer').slideDown()
      $('input#ticket_payment_type').val('fixed')

    self.elems.buttons.priceDonation.click ->
      $('#pricer').slideDown()
      $('input#ticket_payment_type').val('donation')

    $('#pricing > li > span').click (e) =>
      disableButtons()
      setTimeout( () =>
        enableButton(e.target)
      , 200)

    self.elems.buttons.priceFree.click()

  bindSalesWindow: ->
    ticketDayStart = self.elems.date.day_start.pickadate().pickadate('picker')
    ticketTimeStart = self.elems.date.time_start.pickatime().pickatime('picker')
    ticketDayEnd = self.elems.date.day_end.pickadate().pickadate('picker')
    ticketTimeEnd = self.elems.date.time_end.pickatime().pickatime('picker')
    ticketDayEnd.set('select', new Date())
    ticketTimeEnd.set('select', new Date())
    # Pulls it from the form.
    ticketDayStart.set('select', $('input#start_day').pickadate().pickadate('picker').get('select'))
    ticketTimeStart.set('select', $('input#start_time').pickatime().pickatime('picker').get('select'))

self = Portcullis.Tickets.New

Portcullis.bind 'boot', ->
  Portcullis.Tickets.New.bind() if $('form#new_event').length isnt 0
