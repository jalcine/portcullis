require 'spec_helper'

describe :attendee do
  subject { create :user, :attendee }
  let(:ability) { Ability.new(subject) }

  describe Event do
    let(:event) { create :event }
    it { expect(ability.can?(:rsvp, event)).to eq(true) }
    it { expect(ability.can?(:crud, event)).to eq(false) }
  end

  describe Ticket do
    let(:ticket) { create :ticket, :available }
    it { expect(ability.can?(:view, ticket)).to eq(true) }
    it { expect(ability.can?(:order, ticket)).to eq(true) }
    it { expect(ability.can?(:crud, ticket)).to eq(false) }
  end

  describe Order do
    let(:order) { create :order, user: subject, ticket: create(:ticket, :available) }
    it { expect(ability.can?(:create, order)).to eq(true) }
    it { expect(ability.can?(:cancel, order)).to eq(true) }
  end
end
