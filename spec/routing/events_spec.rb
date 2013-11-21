require 'spec_helper'

describe 'events routes' do
  subject { FactoryGirl.create :event }
  it 'shows an event page' do
    expect(get: "/events/#{subject.id}").to route_to({
      action: 'show',
      controller: 'events',
      id: subject.id.to_s
    })
  end

  it 'edits an event' do
    expect(get: "/events/#{subject.id}/edit").to route_to({
      action: 'edit',
      controller: 'events',
      id: subject.id.to_s
    })
  end

  it 'deletes an event' do
    expect(delete: "/events/#{subject.id}").to route_to({
      action: 'destroy',
      controller: 'events',
      id: subject.id.to_s
    })
  end

  it 'updates an event' do
    expect(put: "/events/#{subject.id}").to route_to({
      action: 'update',
      controller: 'events',
      id: subject.id.to_s
    })
  end
end
