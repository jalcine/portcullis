class Portcullis.Models.Order extends Backbone.Model
  urlRoot: '/orders'
  defaults:
    ticket: 0
    quantity: 0

  initializer: (opts) ->
    unless opts is undefined
      return 'Orders require an actual Ticket model' unless typeof opts.ticket is Portcullis.Models.Ticket
    @bind 'change:ticket', (model, ticket) ->
      console.log model, ticket
      return if typeof ticket is Portcullis.Models.Ticket
      @set 'ticket', (new Portcullis.Models.Ticket({id: ticket}))
      @get('ticket').fetch()

  ticket: ->
    @get 'ticket'

  charge: ->
    return -1 unless typeof @ticket() is Portcullis.Models.Ticket
    @ticket().get('price')

  serviceFee: ->
    return 0 if @ticket().get('price') is 0
    fee = 0.025 * @ticket().get('price') + 0.99
    fee = 9.95 if fee > 9.95
    fee

  validate: (attrs) ->
    return 'A referencing ticket is required' if !attrs.ticket
    return 'A quantity is required' if !attrs.quantity
    return 'At least one ticket should be ordered' if attrs.quantity is 0
    return 'Too many tickets were ordered' if attrs.quantity > @ticket().get('max_quantity')
