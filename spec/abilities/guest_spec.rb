require 'spec_helper'

describe :guest do
  subject { FactoryGirl.create :guest_user }
  let(:ability) { Ability.new(subject) }

  describe Event do
    let(:event) { FactoryGirl.create :event }
    it { expect(ability.can?(:view, event)).to eq(true) }
    it { expect(ability.can?(:crud, event)).to eq(false) }
  end

  describe Ticket do
    let(:ticket) { FactoryGirl.create :ticket }
    it { expect(ability.can?(:view, ticket)).to eq(true) }
    it { expect(ability.can?(:crud, ticket)).to eq(false) }
  end

  describe Order do
    let(:order) { FactoryGirl.create :order }
    it { expect(ability.can?(:view, order)).to eq(false) }
    it { expect(ability.can?(:create, order)).to eq(false) }
    it { expect(ability.can?(:cancel, order)).to eq(false) }
  end
end
