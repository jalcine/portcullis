require 'spec_helper'

describe TicketsController do
  before(:each) { login_user }
  subject { FactoryGirl.attributes_for :ticket }
  let(:event) { FactoryGirl.create :event }

  describe 'GET /events/:event_id/tickets/new' do
    it 'passes an object' do
      get :new, event_id: event.id
      expect(assigns(:event)).to_not be_nil
      expect(assigns(:ticket)).to_not be_nil
      expect(assigns(:ticket)).to be_a_new_record
    end
  end

  describe 'POST /events/:event_id/tickets' do
    it 'creates a new ticket' do
      post :create, { ticket: subject, event_id: event.id  }
      expect(response.status).to eq(302)
      expect(assigns(:event)).to_not be_nil
      expect(assigns(:ticket)).to_not be_nil
      expect(assigns(:ticket)).to_not be_a_new_record
      expect(assigns(:ticket)).to be_persisted
    end
  end

  describe 'PUT /events/:event_id/tickets/:id' do
    subject { FactoryGirl.attributes_for :ticket }
    pending 'update tickets'
  end

  describe 'DELETE /events/:event_id/tickets/:id' do
    pending 'delete tickets'
  end

  describe 'GET /events/:event_id/tickets/:id' do
    before(:each) { post :create, {ticket: subject, event_id: event.id } }
    it { expect(assign(:event)).to_not be_nil }
    it { expect(assign(:ticket)).to_not be_nil }
    it { expect(assign(:event).tickets).to_include subject }
    it { expect(assign(:ticket).event).to be(assign(:event))}
    it { expect(response.status).to eq(200) }
  end
end
