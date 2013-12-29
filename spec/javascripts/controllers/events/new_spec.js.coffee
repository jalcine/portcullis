#= require spec_helper
#= require jquery
#= require controllers/events/new

describe 'events/new', ->
  describe 'core', ->
    it 'exists', ->
      expect(Portcullis.Events.New).to.be.ok

  describe 'widgets', ->
    fixture.load('events/new.html.haml')
    $('#teaspoon_fixtures').appendChild fixture.el
    #Portcullis.Events.New.bindEvents()
    it 'sets up time widgets', ->
      timeWidgets = $ 'input[type=time]'
      expect(timeWidgets.pickadate()).to.be.null
      expect(timeWidgets.pickatime()).to.not.be.null
    it 'sets up date widgets', ->
      dateWidgets = $ 'input[type=date]'
      expect(dateWidgets.pickatime()).to.be.null
      expect(dateWidgets.pickadate()).to.not.be.null

  describe 'validation', ->
    describe 'name', ->
      it 'ensures a minimum length of 10 characters'
      it 'ensures spaces are not counted in length'

    describe 'description', ->
      it 'ensures a minimum size of 30 words'

    describe 'date/time', ->
      describe 'date', ->
        it 'prevents end date from being earlier than start date'
      describe 'time', ->
        it 'prevents end time from being earlier than end time'
        it 'disables time for all day events'
