require 'spec_helper'

describe Profile do
  context 'when checking attributes' do
    subject { Profile.new }
    it { expect(subject).to respond_to(:first_name) }
    it { expect(subject).to respond_to(:last_name) }
    it { expect(subject).to respond_to(:middle_name) }
    it { expect(subject).to respond_to(:date_of_birth) }
    it { expect(subject).to respond_to(:phone_number) }
    it { expect(subject).to respond_to(:address) }
    it { expect(subject).to respond_to(:avatar) }
  end

  context 'when validating' do
    describe 'the presence of' do
      [:first_name, :last_name].each do | field |
        it "fails to save without #{field}" do
          p = FactoryGirl.attributes_for :profile
          profile = Profile.new p.except!(field)
          expect{profile.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end
      end
    end
  end

  describe 'avatar' do
    let(:user){ FactoryGirl.create :user }
    let(:profile) { user.create_profile FactoryGirl.attributes_for(:profile).except!(:user_id) }
    let(:kittykat) { File.open("#{Rails.root}/spec/support/images/kittykat.jpg") }

    it { expect(user).to_not be_nil }
    it { expect(profile).to_not be_nil }
    it { expect(profile.avatar).to be_an_instance_of(AvatarUploader)}

    before(:all) { AvatarUploader.storage = :file }
    after(:all)  { AvatarUploader.storage = :fog }

    describe 'uploading' do
      it 'prevents invalid file type uploads' do
        badfile = File.open("#{Rails.root}/Rakefile")
        profile.avatar = badfile
        expect { profile.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      before(:each) do
        profile.avatar = kittykat
        profile.save!
      end

      describe 'via file' do
        it { expect(profile.avatar.url).to_not be_eql('/fallback/default.png') }
        it { expect(profile.avatar.filename).to be_eql('kittykat.png') }
      end

      describe 'removing' do
        before(:each) do
          profile.remove_avatar!
          profile.save!
        end

        it { expect(profile.avatar.url).to be_eql('/fallback/default.png') }
        it { expect(profile.avatar.file).to be_nil }
      end

      it 'can be verisoned' do
      end
    end

    describe 'importing' do
      Settings.authentication.providers.each do | provider |
        let(:my_provider) { Provider.find_by_user_and_name({name: provider, user: user}) }
        it "can be imported from #{provider}" do

        end
      end
    end
  end
end
