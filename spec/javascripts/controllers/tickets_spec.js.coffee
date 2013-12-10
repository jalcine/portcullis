#= require spec_helper
#= require controllers/tickets

describe 'tickets', ->
  describe 'core', ->
    it 'exists', ->
      expect(Portcullis.Tickets).to.be.ok
