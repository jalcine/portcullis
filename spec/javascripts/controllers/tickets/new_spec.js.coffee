#= require spec_helper
#= require controllers/tickets/new

describe 'tickets', ->
  describe 'core', ->
    it 'exists', ->
      expect(Portcullis.Tickets.New).to.be.ok
