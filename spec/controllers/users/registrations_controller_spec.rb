require 'spec_helper'

describe Users::RegistrationsController do
  describe 'PUT create' do
    before(:each) { put :create, user: attributes_for(:user) }
    it 'creates a profile for the user' do
      expect(controller.current_user.profile).to_not be_nil
    end
  end
end
