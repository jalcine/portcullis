require 'spec_helper'

describe Events::TicketsController do
  let(:event) { FactoryGirl.create :event }

  describe 'GET /tickets/new/:event_id' do
    it 'passes an object' do
      get :new, event_id: event
      expect(assigns(:ticket)).to_not be_nil
    end
  end

  describe 'PUT /tickets' do
    subject { FactoryGirl.attributes_for :ticket }
    it 'creates a new ticket' do
      put :create, ticket: subject
      expect(assigns(:ticket)).to_not be_a_new_record
      expect(assigns(:ticket)).to be_persisted
    end
  end

  describe 'DELETE /tickets/:id'
  describe 'GET /tickets/:id'
end
