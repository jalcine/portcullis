require 'spec_helper'

describe Transaction do
  describe 'validations' do
    subject { create :transaction }
    it { expect(subject).to have(:no).errors_on(:orders) }
    it { expect(subject).to have(:no).errors_on(:merchant) }
    it { expect(subject).to be_readonly }
  end

  describe '.authorize!' do
    subject { create :transaction }
    before(:each) { subject.authorize! }
    it { expect(subject).to be_authorized }
  end

  describe '.settle!' do
    subject { create :transaction, :authorized }
    xit { expect(subject).to be_settled }
  end

  describe '.declined?' do
    subject { create :transaction, :declined }
    xit { expect(subject).to be_declined }
  end
end
