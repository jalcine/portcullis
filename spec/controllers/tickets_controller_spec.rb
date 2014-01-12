require 'spec_helper'

describe TicketsController do
  subject { FactoryGirl.attributes_for :ticket }
  let(:event) { FactoryGirl.create :event }
  before(:each) { login_user }

  describe 'DELETE /tickets/:id' do
    let(:ticket) { event.tickets.create FactoryGirl.attributes_for(:ticket) }
    before(:each) { delete :destroy, { id: ticket.id, event_id: event.id } }
    it { expect(assigns(:event)).to_not be_nil }
    it { expect(assigns(:ticket)).to be_destroyed }
    it { expect(response.status).to eql(301) }
  end

  describe 'GET /tickets/new' do
    before(:each){ get :new, { event_id: event.id } }
    it { expect(assigns(:ticket)).to_not be_nil }
  end

  describe 'GET /tickets/:id/edit' do
    let(:ticket) { Ticket.create subject }
    before(:each){ get :edit, { event_id: event.id, id: ticket.id } }
    it { expect(assigns(:ticket)).to_not be_nil }
  end

  describe 'GET /tickets/:id' do
    describe 'shows the ticket' do
      let(:ticket) { Ticket.create subject }
      before(:each) do 
        event.tickets << ticket
        get :show, { id: ticket.id, event_id: event.id }
      end
      it { expect(assigns(:event)).to_not be_nil }
      it { expect(assigns(:ticket)).to_not be_nil }
      it { expect(response.status).to be(302) }
    end
  end

  describe 'PUT /tickets/:id' do
    let(:ticket) { Ticket.create subject }
    subject { FactoryGirl.attributes_for :ticket }
    before(:each) { put :update, { ticket: subject, event_id: event.id, id: ticket.id } }
    it { expect(assigns(:event)).to_not be_nil }
    it { expect(assigns(:ticket)).to_not be_nil }
    it { expect(assigns(:ticket)).to be_persisted }
    it { expect(response.status).to be(302) }
  end

  describe 'POST /tickets' do
    describe 'creates a new ticket' do
      before(:each) { post :create, { ticket: subject, event_id: event.id  } } 
      it { expect(response.status).to be(200) }
      it { expect(assigns(:event)).to_not be_nil }
      it { expect(assigns(:ticket)).to_not be_nil }
      it { expect(assigns(:ticket)).to_not be_a_new_record }
      it { expect(assigns(:ticket)).to be_persisted }
    end
  end
end
