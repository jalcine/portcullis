require 'spec_helper'

describe Event do
  describe :validations do
    subject { FactoryGirl.create :event }
    it { expect(subject).to have(:no).errors_on(:name) }
    it { expect(subject).to have(:no).errors_on(:description) }
    it { expect(subject).to have(:no).errors_on(:user) }
    it { expect(subject).to have(:no).errors_on(:banner) }
    it { expect(subject).to have(:no).errors_on(:address) }
    it { expect(subject).to have(:no).errors_on(:longitude) }
    it { expect(subject).to have(:no).errors_on(:latitude) }
    it { expect(subject).to have(:no).errors_on(:date_start) }
    it { expect(subject).to have(:no).errors_on(:date_end) }
    it { expect(subject).to have(:no).errors_on(:password) }
  end

  describe '.draft?' do
    subject { create :event, :draft }
    it { expect(subject).to be_draft }
  end

  describe '.elapsing' do
    subject { create :event, :ongoing }
    it { expect(subject).to be_elapsing }
    it { expect(subject).to_not be_expired }
  end

  describe '.expired?' do
    subject { create :event, :expired }
    it { expect(subject).to_not be_elapsing }
    it { expect(subject).to be_expired }
  end

  describe '.tickets' do
    describe 'saves tickets' do
      let(:params) { FactoryGirl.attributes_for :event, :with_tickets }
      let(:a_event) { Event.create params }
      it { expect(a_event).to be_persisted }
      it { expect(a_event.errors).to be_empty }
    end

    describe 'lists tickets' do
      let(:a_event) { FactoryGirl.create :event, :with_tickets }
      it { expect(a_event.tickets).to_not be_empty }
    end
  end
end
