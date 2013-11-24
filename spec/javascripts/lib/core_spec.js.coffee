#= require spec_helper
#= require lib/core

describe 'Portcullis', ->
  it 'exists', ->
    expect(Portcullis).to.not.be.null

  it 'boots once', ->
    Portcullis.boot
    expect(Portcullis.boot).to.be.null
