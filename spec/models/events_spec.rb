require 'spec_helper'

describe Event do
  describe 'validations' do
    subject { FactoryGirl.create :event }
    it { expect(subject).to have(:no).errors_on(:name) }
    it { expect(subject).to have(:no).errors_on(:description) }
    it { expect(subject).to have(:no).errors_on(:user) }
    it { expect(subject).to have(:no).errors_on(:address) }
    it { expect(subject).to have(:no).errors_on(:longitude) }
    it { expect(subject).to have(:no).errors_on(:latitude) }
    it { expect(subject).to have(:no).errors_on(:date_start) }
    it { expect(subject).to have(:no).errors_on(:date_end) }
    it { expect(subject).to have(:no).errors_on(:access_key) }
  end

  describe '.tickets' do
    it 'saves tickets' do
      params = FactoryGirl.attributes_for :event, :with_tickets
      a_event = Event.create params
      expect(a_event).to be_persisted
      expect(a_event.errors).to be_empty
    end

    it 'lists tickets' do
      a_event = FactoryGirl.create :event, :with_tickets
      expect(a_event.tickets).to_not be_empty
    end
  end
end
