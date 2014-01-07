require 'spec_helper'

describe 'order routes' do
  subject { FactoryGirl.create :order }
  it 'shows an ticket page' do
    expect(get: "/orders/#{subject.id}").to route_to({
      controller: :orders,
      action: :show,
      id: subject.id
    })
  end

  it 'edits an ticket' do
    expect(get: "/orders/#{subject.id}/edit").to route_to({
      controller: :orders,
      action: :edit,
      id: subject.id
    })
  end

  it 'deletes an ticket' do
    expect(delete: "/orders/#{subject.id}").to route_to({
      controller: :orders,
      action: :destroy,
      id: subject.id
    })
  end
end
