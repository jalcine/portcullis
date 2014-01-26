class Portcullis.Models.Ticket extends Backbone.Model
  urlRoot: '/tickets'
  defaults:
    price: 0
    date_start: new Date
    date_end: new Date
    name: ""
    description: ""
    quantity: 0
    max_quantity: 0

  isFree: ->
    parseFloat(@get('price')) == 0

  isPriced: ->
    !@isFree

  validate : (attrs) =>
    return 'A name for the ticket is required' if !attrs.name?
    return 'A description for the ticket is required' if !attrs.name?
