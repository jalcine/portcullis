require 'spec_helper'

describe User do

  context 'when checking attributes' do
    subject { FactoryGirl.create :user }

    it { expect(subject).to respond_to(:email) }
    it { expect(subject).to respond_to(:id) }
    it { expect(subject).to respond_to(:role) }
    it { expect(subject).to respond_to(:roles) }
    it { expect(subject).to respond_to(:providers) }
    it { expect(subject).to respond_to(:password) }
    it { expect(subject).to respond_to(:password_confirmation) }
  end

  describe '.new' do
    it 'can create a valid user with no providers' do
      params = ActionController::Parameters.new(FactoryGirl.attributes_for :user)
      u = User.create params.permit!
      expect(u).to_not be_nil
      expect(u).to be_persisted
    end
  end

  Settings.authentication.providers.each do | provider_name, __ |
    describe '.find_by_oauth' do
      describe 'lookup on malformed data' do
        ['provider','uid'].each do | key |
          let(:oauth)  { oauth_hash(provider_name).extract! key, 'info', 'credentials' }
          subject { User.build_with_oauth oauth }
          it { expect(subject).to be_nil }
        end
      end

      describe "oauth data from #{provider_name}" do
        subject { User.build_with_oauth oauth_hash(provider_name) }
        it { expect(subject).to_not be_nil }
        it { expect(subject).to be_persisted }
        it { expect(subject.email).to_not be_nil }
        it { expect(subject.providers).to_not be_empty }
      end
    end

    describe '.build_with_oauth' do
      describe "can create an user with data from #{provider_name}" do
        let(:oauth)  { oauth_hash(provider_name) }
        subject { User.build_with_oauth(oauth) }
        it { expect(User.build_with_oauth(oauth)).to_not be_nil }
        it { expect(subject).to_not be_nil }
        it { expect(subject).to be_persisted }
        it { expect(subject.providers.first.name.to_sym).to be_eql(provider_name.to_sym) }
        it { expect(subject.providers).to have(1).records }
        it { expect(subject.email).to be_eql(oauth['info']['email']) }
      end

      describe "can find an user from a #{provider_name}-built provider" do
        let(:provider) { create(:provider, provider_name) }
        let(:user) { provider.user }
        it { expect(user).to_not be_nil }
        it { expect(user.providers.first.name.to_s).to include(provider_name.to_s)}
      end
    end
  end

  context 'when handling roles' do
    describe '.role' do
      subject { FactoryGirl.create :user }
      it { expect(subject.roles).to have(1).records }
      it { expect(subject.role).to_not be_nil }
    end

    describe '.roles' do
      it 'always has a role' do
        u = FactoryGirl.create :user, :guest
        u.remove_role :guest
        u.save!
        expect(u.roles).to have(1).records
      end
    end
  end

  describe '.permissions_for' do
    describe 'facebook' do
      pending 'implement testing of facebook permissions check'
    end

    [:linkedin].each do | provider |
      describe provider do
        pending "implement testing of #{provider} permissions check"
      end
    end
  end
end
