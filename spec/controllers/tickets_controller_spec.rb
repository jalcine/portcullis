require 'spec_helper'

describe TicketsController do
  let(:event) { FactoryGirl.create :event }

  describe 'GET /events/:event_id/tickets/new' do
    it 'passes an object' do
      get :new, event_id: event
      expect(assigns(:ticket)).to_not be_nil
    end
  end

  describe 'POST /events/:event_id/tickets' do
    subject { FactoryGirl.attributes_for :ticket }
    let(:event) { FactoryGirl.create :event }
    it 'creates a new ticket' do
      post :create, { ticket: subject, event_id: event.id  }
      expect(response.status).to eq(200)
      expect(assigns(:ticket)).to_not be_nil
      expect(assigns(:ticket)).to_not be_a_new_record
      expect(assigns(:ticket)).to be_persisted
    end
  end

  describe 'PUT /events/:event_id/tickets/:id' do
    pending 'update tickets'
  end

  describe 'DELETE /events/:event_id/tickets/:id' do
    pending 'delete tickets'
  end

  describe 'GET /events/:event_id/tickets/:id' do
    pending 'show tickets'
  end
end
