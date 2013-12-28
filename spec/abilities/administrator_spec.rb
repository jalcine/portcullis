require 'spec_helper'

describe :administrator do
  subject { FactoryGirl.create :user, :administrator }
  let(:ability) { Ability.new(subject) }

  describe Event do
    let(:event) { FactoryGirl.create :event }
    it { expect(ability.can?(:manage, event)).to eq(true) }
  end

  describe Ticket do
    let(:ticket) { FactoryGirl.create :ticket }
    it { expect(ability.can?(:manage, ticket)).to eq(true) }
  end

  describe Order do
    let(:order) { FactoryGirl.create :order }
    it { expect(ability.can?(:manage, order)).to eq(true) }
  end
end
