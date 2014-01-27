class Portcullis.Views.OrdersShow extends Backbone.View
  template: JST['orders/show']
  tagName: 'li'
  className: 'order'
  constructor: (opts) ->
    @model = opts.model || null
    console.log @model
  render: ->
    console.log @model.ticket()
    data =
      name: @model.ticket().get 'name'
      charge: @model.charge()
      service_fee: @model.service()
      quantity: @model.quantity()
    @$el = $(@template({}))
    @
  cancelOrder: ->
    # TODO Remove from the parent collection.
