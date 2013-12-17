require 'spec_helper'

describe Order do
  describe 'validations' do
    subject { FactoryGirl.create :order }
    it { expect(subject).to have(:no).errors_on(:ticket) }
    it { expect(subject).to have(:no).errors_on(:user) }
  end

  describe 'processing' do
    let(:ticket) { FactoryGirl.create :ticket }
    let(:user) { FactoryGirl.create :user }
    it 'starts processing a new order' do
      order = Order.create! ticket: ticket, user: user
      expect(order).to be_processing
    end
  end
end
