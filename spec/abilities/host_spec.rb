require 'spec_helper'

describe :host do
  subject { FactoryGirl.create :host_user }
  let(:ability) { Ability.new(subject) }

  describe 'its own' do
    describe Event do
      let(:event) { FactoryGirl.create :event }
      before(:each) do
        subject.grant :host, event
        event.owner = subject
      end
      it { expect(ability.can?(:crud, event)).to eq(true) }
      it { expect(ability.can?(:modify, event)).to eq(true) }
    end

    describe Ticket do
      let(:ticket) { FactoryGirl.create :ticket }
      before(:each) do
        subject.grant :host, ticket.event
        ticket.event.owner = subject
      end
      it { expect(ability.can?(:crud, ticket)).to eq(true) }
      it { expect(ability.can?(:modify, ticket)).to eq(true) }
    end

    describe Order do
      let(:order) { FactoryGirl.create :order }
      it { except(ability.can?(:create, order).to eq(false)) }
      it { except(ability.can?(:cancel, order).to eq(false)) }
    end
  end
end
