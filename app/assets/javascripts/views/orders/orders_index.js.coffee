class Portcullis.Views.OrdersIndex extends Backbone.View
  template: JST['orders/index']
  tagName: 'div'
  className: 'reveal-model order-dialog'
  orders: null

  confirmOrder: ->

  initialize: (opts) ->
    @orders = opts.orders || new Portcullis.Collections.Orders

  render: ->
    @$el = $(@template())
    @$el

  showModal: ->
    @render()
    @$el.appendTo($(document.body))
    $(@el).foundation('reveal', 'open', {})
    @addAllOrders()

  addOrder: (order) ->
    view = new Portcullis.Views.OrdersShow {model: order}
    @$('table:first > tbody').append view.render().el

  clearAllOrders: ->
    @$('table:first > tbody').html ''

  addAllOrders: ->
    @clearAllOrders()
    @orders.forEach @addOrder, @
