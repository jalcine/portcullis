require 'spec_helper'

describe Provider do
  describe 'check attribute exists' do
    subject { FactoryGirl.create :provider }
    it { expect(subject).to respond_to(:name) }
    it { expect(subject).to respond_to(:uid) }
    it { expect(subject).to respond_to(:token) }
    it { expect(subject).to respond_to(:user) }
  end

  describe '#save!' do
    context 'when checking uniqueness of fields' do
      Settings.authentication.providers.each do | provider, _ |
        subject { FactoryGirl.create :provider, provider }

        it 'has a unique token' do
          p = FactoryGirl.build :provider, provider,  token: subject.token
          expect{p.save!}.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end

  describe '.import_from_oauth' do
    Settings.authentication.providers.each do | provider, data |
      let(:oauth) { oauth_hash provider }
      describe "import from #{provider}" do
        subject { FactoryGirl.create :provider, provider }
        before(:each) do
          subject.user = FactoryGirl.create :user
          subject.user.providers << subject
          subject.user.save!
          subject.save!
          subject.import_from_oauth oauth[:info]
        end

        it 'has a profile' do
          expect(subject.user.profile).to_not be_nil
          expect(subject.user.profile).to be_persisted
        end
      end
    end
  end
end
