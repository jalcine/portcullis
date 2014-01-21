require 'spec_helper'

describe Transaction, slow: true do
  describe 'validations' do
    describe 'authorized' do
      subject { create :transaction, :authorized }
      it { expect(subject).to have(:no).errors_on(:orders) }
      it { expect(subject).to have(:no).errors_on(:merchant) }
    end
  end

  describe '.authorize!' do
    subject { create :transaction, :authorized }
    before(:each) { subject.authorize! }

    it { expect(subject).to have(:no).errors }
    it { expect(subject).to be_readonly }
    it { expect(subject).to be_authorized }
    it { expect(subject).to_not be_settled }
    it { expect(subject).to_not be_declined }
  end

  describe '.settle!', broken: true do
    subject { create :transaction, :authorized }
    before(:each) { subject.settle! }

    it { expect(subject).to have(:no).errors }
    it { expect(subject).to be_readonly }
    it { expect(subject).to be_settled }
    it { expect(subject).to be_authorized }
    it { expect(subject).to_not be_declined }
  end

  describe '.declined?', braintree: :decline, broken: true do
    subject { create(:transaction, :authorized) }

    it { expect(subject).to have(:no).errors }
    it { expect(subject).to be_readonly }
    it { expect(subject).to be_declined }
    it { expect(subject).to_not be_authorized }
    it { expect(subject).to_not be_settled }
  end
end
