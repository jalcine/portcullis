require 'spec_helper'

describe 'order routes' do
  subject { FactoryGirl.create :order }
  it 'shows an ticket page' do
    expect(get: "/orders/#{subject.id}").to route_to(order_path(subject))
  end

  it 'edits an ticket' do
    expect(get: "/orders/#{subject.id}/edit").to route_to(edit_order_path(subject))
  end

  it 'deletes an ticket' do
    expect(delete: "/orders/#{subject.id}").to route_to(order_path(subject))
  end
end
