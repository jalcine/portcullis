#= require spec_helper
#= require controllers/tickets/new

describe 'tickets/new', ->
  it 'exists', ->
    expect(Portcullis.Tickets.New).to.be.ok
