class Portcullis.Models.Ticket extends Backbone.Model
  urlRoot: '/tickets'
  defaults:
    price: 0
    date_start: new Date
    date_end: new Date
    name: ""
    description: ""
    quantity: 0

  validate : (attrs) =>
    return 'A name for the ticket is required' if !attrs.name?
    return 'A description for the ticket is required' if !attrs.name?
