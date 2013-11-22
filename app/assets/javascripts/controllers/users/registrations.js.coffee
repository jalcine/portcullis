#= require lib/core
Portcullis.SignUp =
  handleRole: ->
    buttons = $('.page.buttons > a')
    buttons.each (index, elem) ->
      elem = $(elem)
      elem.click (event) ->
        event.preventDefault()
        elem.attr('href',"#{elem.attr('href')}?task=new")
        location.href = elem.attr('href')
        return false

$ ->
  #Portcullis.SignUp.handleRole()
