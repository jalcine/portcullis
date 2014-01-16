require 'spec_helper'

describe Transaction do
  subject { create :transaction }
  describe 'validations' do
    it { expect(subject).to have(:no).errors_on(:orders) }
    it { expect(subject).to have(:no).errors_on(:merchant) }
  end

  describe '.authorize!', broken: true do
    subject { create :transaction }
    before(:each) { subject.authorize! }
    it { expect(subject).to be_authorized }
    it { expect(subject).to be_readonly }
  end

  describe '.settle!', braintree_settling: true, broken: true do
    subject { create :transaction, :authorized }
    before(:each) { subject.settle! }
    it { expect(subject).to be_settled }
  end

  describe '.declined?', decline_transactions: true, broken: true do
    subject { create :transaction, :authorized }
    before(:each) { subject.authorize! }
    it { expect(subject).to be_declined }
  end
end
