require 'spec_helper'

describe Ticket do
  describe 'validations' do
    subject { create :ticket }
    it { expect(subject).to have(:no).errors_on(:name) }
    it { expect(subject).to have(:no).errors_on(:description) }
    it { expect(subject).to have(:no).errors_on(:event) }
    it { expect(subject).to have(:no).errors_on(:quantity) }
    it { expect(subject).to have(:no).errors_on(:max_quantity) }
    it { expect(subject).to have(:no).errors_on(:price) }
    it { expect(subject).to have(:no).errors_on(:payment_type) }
    it { expect(subject).to have(:no).errors_on(:date_start) }
    it { expect(subject).to have(:no).errors_on(:date_) }
  end

  describe '.expired?' do
    subject { create :ticket, :expired }
    it { expect(subject).to be_expired }
    it { expect(subject).to_not be_available }
  end

  describe '.available?' do
    subject { create :ticket, :available }
    #it { expect(subject).to be_available }
  end

  describe '.purchase' do
    let(:user) { create :user, :attendee }
    subject { create :ticket, :priced }
    it 'produces a new order before the event starts' do
      subject.event = create :event
      order = subject.purchase_for user
      expect(order).to_not be_nil
      expect(order.ticket).to be(subject)
      #expect(order).to be_payment_pending
    end

    it 'prevents expired tickets from being sold' do
      subject.event = create :event, :expired
      order = subject.purchase_for user
      expect(order).to be_nil
    end
  end

  describe '.refund' do
    let(:user) { FactoryGirl.create :user, :attendee }
    let(:order) { order = subject.purchase_for user }
    subject { FactoryGirl.create :ticket, :priced }

    xit 'issues refund before the event starts' do
      refund = subject.issue_refund_for order
      expect(refund).to_not be_nil
      expect(refund).to be_processing
    end

    xit 'prevents past events from issuing refunds' do
      refund = subject.issue_refund_for order
      expect(refund).to be_nil
    end
  end
end
