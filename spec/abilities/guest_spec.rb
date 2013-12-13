require 'spec_helper'

describe 'Guest' do
  subject { FactoryGirl.create :guest_user }

  describe Event do
    let(:event) { FactoryGirl.create :event }
    it { expect { subject.can? :view,   event }.to be_true }
    it { expect { subject.can? :modify, event }.to be_false }
  end

  describe Ticket do
    let(:ticket) { FactoryGirl.create :ticket }
    it { expect { subject.can? :view,   ticket }.to be_true }
    it { expect { subject.can? :modify, ticket }.to be_false }
  end
end
