class Portcullis.Views.TicketsShow extends Backbone.View
  tagName: 'li'
  template: JST['tickets/show']
  events: {}
  render: () =>
    @$el.html @template(@model.toJSON())
