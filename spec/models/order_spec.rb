require 'spec_helper'

describe Order do
  describe 'validations' do
    subject { FactoryGirl.create :order }
    it { expect(subject).to have(:no).errors_on(:ticket) }
    it { expect(subject).to have(:no).errors_on(:user) }
    it { expect(subject).to have(:no).errors_on(:transaction) }
    it { expect(subject).to have(:no).errors_on(:charge) }
  end

  describe '.new' do
    describe 'creates a new order for a priced ticket' do
      let(:ticket) { create(:ticket, :free) }
      before(:each) do
        @order = Order.new user: create(:user, :attendee),
          ticket: ticket, quantity: 6
        @order.save
      end

      it { expect(@order).to have(:no).errors }

      it 'doesnt have a transaction ' do
        expect(@order.transaction).to be_nil
      end

      it 'must have a zero charge' do
        expect(@order.charge).to be_zero
      end
    end

    describe 'creates a new order for a priced ticket' do
      let(:ticket) { create(:ticket, :priced) }
      before(:each) do
        @order = Order.new user: create(:user, :attendee),
          ticket: ticket, quantity: 6
        @order.save
      end

      it { expect(@order).to have(:no).errors }

      it 'doesnt have a transaction ' do
        expect(@order.transaction).to be_nil
      end

      it 'has a nonzero charge' do
        expect(@order.charge).to_not be_zero
      end
    end
  end
end
