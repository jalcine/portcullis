#= require spec_helper
#= require controllers/tickets/index

describe 'tickets/index', ->
  it 'exists', ->
    expect(Portcullis.Tickets.Index).to.not.be.null
