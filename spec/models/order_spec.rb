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
      it { expect(subject.charge).to be subject.ticket.price }
    end
  end

  describe '.service_fee' do
    describe 'free tickets' do
      subject { create(:order, user: create(:user, :attendee), ticket: create(:ticket, :free) ) }
      it { expect(subject.service_fee).to be_zero }
    end

    describe 'priced tickets' do
      subject { create(:order, user: create(:user, :attendee), ticket: create(:ticket, :priced) ) }
      it { expect(subject.service_fee).to_not be_zero }
      it { expect(subject.service_fee).to_not be > 995 }
    end

    describe 'donational tickets' do
      let(:price) { Random.rand(3000).to_i + 1 }
      subject { create(:order, user: create(:user, :attendee), ticket: create(:ticket, :donation, price: price) ) }
      it { expect(subject.service_fee).to_not be > 995 }
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
