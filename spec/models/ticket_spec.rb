require 'spec_helper'

describe Ticket do
  describe 'validations' do
    subject { FactoryGirl.create :ticket }
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
  describe '.purchase' do
    xit 'produces a new order before the event starts'
    xit 'prevents expired tickets from being sold'
  end
  describe '.refund' do
    xit 'issues refund before the event starts'
    xit 'prevents past events from issuing refunds'
  end
end
