#= require spec_helper
#= require users/profiles/new

describe 'user/profile/new', ->
  describe 'core', ->
    it 'exists', ->
      expect(Portcullis.NewProfile).to.be.ok
