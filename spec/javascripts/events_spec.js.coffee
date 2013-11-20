#= require spec_helper
#= require events

describe 'events', ->
  describe 'core', ->
    it 'exists', ->
      expect(Portcullis.Events).to.be.ok
