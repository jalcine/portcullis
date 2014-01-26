class Portcullis.Collections.Tickets extends Backbone.Collection
  event: null
  model: Portcullis.Models.Ticket

  constructor : (event) ->
    this.event = event
