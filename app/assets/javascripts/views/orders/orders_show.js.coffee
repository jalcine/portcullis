class Portcullis.Views.OrdersShow extends Backbone.View
  template: JST['orders/show']
  tagName: 'li'
  className: 'order'
  constructor: (opts) ->
    @model = opts.model || null
  render: ->
    @model.ticket().fetch()
    data = {
      name: @model.ticket().get 'name'
      charge: @model.charge()
      service_fee: @model.serviceFee()
      quantity: parseFloat(@model.get('quantity'))
    }
    @$el = $(@template(data))
    @
  cancelOrder: ->
    # TODO Remove from the parent collection.
