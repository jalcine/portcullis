#= require spec_helper
#= require lib/core

describe 'Melody', ->
  it 'exists', ->
    expect(Melody).to.not.be.null

  it 'boots once', ->
    Melody.boot
    expect(Melody.boot).to.be.null
