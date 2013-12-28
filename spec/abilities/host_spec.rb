require 'spec_helper'

describe :host do
  subject { FactoryGirl.create :user, :host }
  let(:ability) { Ability.new(subject) }

  describe 'its own' do
    describe Event do
      let(:event) { FactoryGirl.create :event, owner: subject }
      before(:each) { subject.grant(:host, event) }
      describe 'has permission to change' do
        it { expect(ability.can?(:modify, event)).to eq(true) }
        it { expect(ability.can?(:crud, event)).to eq(true) }
      end
    end

    describe Ticket do
      let(:ticket) { FactoryGirl.create :ticket }
      before(:each) do
        subject.grant(:host, ticket.event)
        ticket.event.owner = subject
      end
      describe 'has permission to change' do
        it { expect(ability.can?(:modify, ticket)).to eq(true) }
        it { expect(ability.can?(:crud, ticket)).to eq(true) }
      end
    end

    describe Order do
      let(:order) { FactoryGirl.create :order }
      it { expect(ability.can?(:create, order)).to eq(false) }
      it { expect(ability.can?(:cancel, order)).to eq(false) }
    end
  end
end
