#= require spec_helper
#= require controllers/users/profiles/new

describe 'controllers/users/profile/new', ->
  describe 'core', ->
    it 'exists', ->
      expect(Portcullis.NewProfile).to.be.ok
