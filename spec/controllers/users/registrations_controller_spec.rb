require 'spec_helper'

describe Users::RegistrationsController do
  describe 'PUT create' do
    before(:each) do
      stub_env_for_devise :user
      put :create, user: attributes_for(:user),
        profile: attributes_for(:profile).extract!(:first_name, :last_name)
    end

    it 'creates a profile for the user' do
      expect(controller.current_user.profile).to_not be_nil
    end
  end
end
