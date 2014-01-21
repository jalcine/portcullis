require 'spec_helper'

describe Order do
  describe 'validations' do
    describe 'free ticket' do
      subject { create :order, ticket: create(:ticket, :free) }
      it { expect(subject).to have(:no).errors_on(:ticket) }
      it { expect(subject).to have(:no).errors_on(:user) }
      it { expect(subject).to have(:no).errors_on(:transaction) }
      it { expect(subject).to have(:no).errors_on(:charge) }
      it { expect(subject.charge).to be_zero }
    end

    describe 'donation ticket' do
      subject { create :order, ticket: create(:ticket, :donation) }
      it { expect(subject).to have(:no).errors_on(:ticket) }
      it { expect(subject).to have(:no).errors_on(:user) }
      it { expect(subject).to have(:no).errors_on(:transaction) }
      it { expect(subject).to have(:no).errors_on(:charge) }
    end

    describe 'priced ticket' do
      subject { create :order, ticket: create(:ticket, :priced) }
      it { expect(subject).to have(:no).errors_on(:ticket) }
      it { expect(subject).to have(:no).errors_on(:user) }
      it { expect(subject).to have(:no).errors_on(:transaction) }
      it { expect(subject).to have(:no).errors_on(:charge) }
      it { expect(subject.charge).to be_nonzero }
      it { expect(subject.charge).to be subject.ticket.price+subject.ticket.service_fee }
    end
  end

  describe '.new' do
    let(:order) { create(:order, user: create(:user, :attendee), ticket: ticket) }
    describe 'creates a new order for a priced ticket' do
      let(:ticket) { create(:ticket, :free) }
      it { expect(order).to have(:no).errors }
      it { expect(order.transaction).to be_nil }
      it { expect(order.charge).to be_zero }
    end

    describe 'creates a new order for a priced ticket' do
      let(:ticket) { create(:ticket, :priced) }

      it { expect(order).to have(:no).errors }
      it { expect(order.transaction).to be_nil }
      it { expect(order.charge).to_not be_zero }
    end
  end
end
