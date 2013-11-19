require 'spec_helper'

describe 'events routes' do
  describe 'shows an event' do
    subject { FactoryGirl.build :event }
    it { expect(get: "/events/#{subject.id}").to route_to(subject) }
  end
  xit 'edits an event'
  xit 'updates an event'
end
