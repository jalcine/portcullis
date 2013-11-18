#= require lib/core

$('a.item').attr 'data-no-turbolinks', true
$('a.item').on 'click', (event) ->
  event.preventDefault()
  Melody.NewProfile.Events.toggleSelection $(this)
  false

Melody.NewProfile =
  Events:
    select: (elem) ->
    unselect: (elem) ->
    toggleSelection: (elem) ->
  Genres:
    select: (elem) ->
    unselect: (elem) ->
    toggleSelection: (elem) ->
