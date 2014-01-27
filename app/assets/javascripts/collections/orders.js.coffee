class Portcullis.Collections.Orders extends Backbone.Collection
  model: Portcullis.Models.Order
  totalPrice: ->
    final_price = 0
    for order in orders
      do (order) =>
        final_price += order.charge() + order.fee()
    final_price
