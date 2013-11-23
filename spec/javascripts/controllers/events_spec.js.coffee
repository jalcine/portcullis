#= require spec_helper
#= require controllers/events

describe 'events', ->
  describe 'core', ->
    it 'exists', ->
      expect(Portcullis.Events).to.be.ok
