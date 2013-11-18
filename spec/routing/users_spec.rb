require 'spec_helper'

describe 'users routes' do
  describe 'authentication' do
    it { expect(get: '/join').to be_routable }
    it { expect(delete: '/logout').to be_routable }

    context 'when logging in' do
      it { expect(get: '/login').to be_routable }
      describe 'using omniauth' do
        Settings.authentication.providers.each do |provider, options| 
          it { expect(get:  "/auth/#{provider}").to be_routable }
          it { expect(post: "/auth/#{provider}").to be_routable }
          it { expect(get:  "/auth/#{provider}/callback").to be_routable }
          it { expect(post: "/auth/#{provider}/callback").to be_routable }
        end
      end
    end
  end

  context 'when going to the profile' do
    subject { FactoryGirl.create :user }
    before(:each) do
      subject.create_profile FactoryGirl.attributes_for(:profile)
      subject.save!
    end

    it { expect(get: '/u/search').to be_routable }
    it { expect(get: "/u/#{subject.profile.to_param}").to be_routable }
    it { expect(get: '/u/edit').to be_routable }
    it { expect(put: '/u/edit').to be_routable }
  end
end
