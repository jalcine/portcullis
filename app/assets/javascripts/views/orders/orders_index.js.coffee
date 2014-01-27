class Portcullis.Views.OrdersIndex extends Backbone.View
  template: JST['orders/index']
  tagName: 'div'
  className: 'reveal-model'
  orders: null
  events:
    'button#confirm_order click' : @confirmOrder

  confirmOrder: ->
    alert 'YO'

  initialize: (opts) ->
    @orders = opts.orders || new Portcullis.Collections.Orders

  render: ->
    @$el = $(@template())
    @$el

  updateTotalPrice: ->
    price_box = $('table:first > tfoot > tr > td:nth-child(2)')
    price_box.html "Total: <b>$#{orders.totalPrice()}</b>"

  showModal: ->
    @render()
    @$el.appendTo($(document.body))
    @$el.foundation()
    @$el.data 'reveal-init', Foundation.libs.reveal.settings
    @$el.foundation('reveal', 'open')
    @addAllOrders()
    @updateTotalPrice()

  addOrder: (order) ->
    view = new Portcullis.Views.OrdersShow {model: order}
    view.render().$el.appendTo @$('table:first > tbody')
    order

  clearAllOrders: ->
    @$('table:first > tbody').html ''

  addAllOrders: ->
    @clearAllOrders()
    @orders.forEach @addOrder, @
