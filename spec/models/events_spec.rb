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
  end

  describe '.tickets' do
    let(:ticket_attrs) { FactoryGirl.attributes_for :ticket }
    it 'saves tickets' do
      params = FactoryGirl.attributes_for :event
      params[:tickets_attributes] =  [ ticket_attrs ]
      a_event = Event.create params
      expect(a_event).to be_persisted
      expect(a_event.errors).to be_empty
    end
  end
end
