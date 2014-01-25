class Portcullis.Models.Event extends Backbone.Model
  urlRoot: '/events'
  defaults:
    name: ""
    description: ""
    date_start: (new Date)
    date_end: (new Date)
    longitude: 0
    latitude: 0
    primary_category: null
    secondary_category: null
    tickets: []
