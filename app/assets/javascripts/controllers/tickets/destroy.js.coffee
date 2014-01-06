#= require controllers/tickets

Portcullis.Tickets.Delete =
  bind: ->
    $('a[data-ticket-action=delete]').on 'ajax:beforeSend', ->
      $(@).addClass 'disabled'
    .on 'ajax:complete', (je, xhr, status) ->
      $(@).removeClass 'disabled'
      if xhr.status == 301
        $(@).parents('li.ticket[data-ticket]').remove()
      else
        alert 'Issue deleting this ticket. Please try again.'

Portcullis.bind 'boot', ->
  Portcullis.Tickets.Delete.bind()
