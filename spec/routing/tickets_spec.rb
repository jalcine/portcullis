require 'spec_helper'

describe 'tickets routes' do
  subject { FactoryGirl.create :ticket }
  it 'shows an ticket page' do
    expect(get: "/tickets/#{subject.id}").to route_to({
      action: 'show',
      controller: 'tickets',
      id: subject.id.to_s
    })
  end

  it 'edits an ticket' do
    expect(get: "/tickets/#{subject.id}/edit").to route_to({
      action: 'edit',
      controller: 'tickets',
      id: subject.id.to_s
    })
  end

  it 'deletes an ticket' do
    expect(delete: "/tickets/#{subject.id}").to route_to({
      action: 'destroy',
      controller: 'tickets',
      id: subject.id.to_s
    })
  end

  it 'updates an ticket' do
    expect(put: "/tickets/#{subject.id}").to route_to({
      action: 'update',
      controller: 'tickets',
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
