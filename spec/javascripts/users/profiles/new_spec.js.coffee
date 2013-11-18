#= require spec_helper
#= require templates/users/profiles/new/item
#= require users/profiles/new

describe 'user/profile/new', ->
  describe 'core', ->
    it 'exists', ->
      expect(Melody.NewProfile).to.be.ok

  describe 'events', ->
    beforeEach ->
      $('body').html(JST['templates/users/profiles/new/item']({
        id: 3,
        label: 'foo',
        description: 'ffff'
      }))
      console.log "Here's a joke: #{$('body').html()}"
    it 'exists', ->
      expect(Melody.NewProfile.Events).to.be.ok
    describe 'rendering', ->
      it 'fetches event types'
      it 'renders an event'
      it 'renders all of the events'
    describe 'interactivity', ->
      it 'selects', ->
      it 'unselects'
      it 'toggle selections'
    describe 'constraints', ->
      it 'prevent more than 3 items from being selected'
      it 'confirms selection of 3 items'

  describe 'genres', ->
    it 'exists', ->
      expect(Melody.NewProfile.Genres).to.be.ok
    describe 'rendering', ->
      it 'fetches event types'
      it 'renders an event'
      it 'renders all of the events'
    describe 'interactivity', ->
      it 'selects'
      it 'unselects'
      it 'toggle selections'
    describe 'constraints', ->
      it 'sets the primary genre'
      it 'sets the secondary genre'
      it 'confirms selection of genres'
