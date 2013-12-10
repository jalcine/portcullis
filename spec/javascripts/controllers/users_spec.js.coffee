#= require spec_helper
#= require controllers/users

describe 'users', ->
  describe 'core', ->
    it 'exists', ->
      expect(Portcullis.Users).to.be.ok
