require 'spec_helper'

describe 'tickets routes' do
  subject { FactoryGirl.create :ticket }
  it 'shows an ticket page' do
    expect(get: "/events/#{subject.event.id}/tickets/#{subject.id}").to route_to({
      action: 'show',
      controller: 'tickets',
      event_id: subject.event.id.to_s,
      id: subject.id.to_s
    })
  end

  it 'edits an ticket' do
    expect(get: "/events/#{subject.event.id}/tickets/#{subject.id}/edit").to route_to({
      action: 'edit',
      controller: 'tickets',
      event_id: subject.event.id.to_s,
      id: subject.id.to_s
    })
  end

  it 'deletes an ticket' do
    expect(delete: "/events/#{subject.event.id}/tickets/#{subject.id}").to route_to({
      action: 'destroy',
      controller: 'tickets',
      event_id: subject.event.id.to_s,
      id: subject.id.to_s
    })
  end

  it 'updates an ticket' do
    expect(put: "/events/#{subject.event.id}/tickets/#{subject.id}").to route_to({
      action: 'update',
      controller: 'tickets',
      event_id: subject.event.id.to_s,
      id: subject.id.to_s
    })
  end

  it 'creates an ticket' do
    expect(post: "/events/#{subject.event.id}/tickets", ticket: FactoryGirl.attributes_for(:ticket)).to route_to({
      action: 'create',
      event_id: subject.event.id.to_s,
      controller: 'tickets'
    })
  end
end