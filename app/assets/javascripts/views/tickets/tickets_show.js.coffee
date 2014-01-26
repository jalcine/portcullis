class Portcullis.Views.TicketsShow extends Backbone.View
  _timer: 0
  tagName: 'li'
  className: 'ticket'
  el : ->
    "li[data-ticket-id='" + @model.get('id') + "'].ticket"
  events: {
    'input[data-ticket=quantity] change' : @validateRange
  }
  render: =>
    @updateTiming()
  validateRange: ->
    return true if @model.isFree()
    order_field = @$ 'input[data-ticket=quantity]'
    order_count = parseInt(order_field.val())
    max_size = Number.POSITIVE_INFINITY
    max_size = parseInt(order_field.attr('max')) if order_field.is('[max]')
    min_size = parseInt(order_field.attr('min'))
    min_size <= order_count and order_count <= max_size
  obtainTimeRange: ->
    date_start = Date.parse(@model.get('date_start'))
    date_end = Date.parse(@model.get('date_end'))
    date_now = new Date
    is_in_future = date_start > date_now
    is_in_past = date_end < date_now
    {
      is_future:   is_in_future
      is_past:     is_in_past
      is_current:  !is_in_past && !is_in_future
    }
  updateTimeSensitiveClasses: ->
    time_range = @obtainTimeRange()
    @$el.removeClass 'current past future'
    @$el.addClass 'current' if time_range.is_current == true
    @$el.addClass 'past' if time_range.is_past == true
    @$el.addClass 'future' if time_range.is_future == true
  reparseTimeField: ->
    time_range = @obtainTimeRange()
    time_field = @$ 'span.time'
    time_field.html '<i class="fa fa-spin fa-refresh"></i>'
    prefix = ''
    prefix = 'opens ' if time_range.is_future
    prefix = 'closes ' if time_range.is_current
    prefix = 'closed ' if time_range.is_past
    timing = new Date(Date.parse(@model.get('date_end'))) if time_range.is_current or time_range.is_past
    timing = new Date(Date.parse(@model.get('date_start'))) if time_range.is_future
    time_tag = $('<time></time>')
    time_tag.attr('data-timeago', timing.toISOString()).attr('datetime', timing.toISOString())
    time_field.text prefix
    time_tag.appendTo time_field
    time_tag.timeago 'updateFromDOM'
  updateTiming: ->
    @reparseTimeField()
    @updateTimeSensitiveClasses()
    @_timer = setTimeout =>
      @updateTiming()
    , 6000
