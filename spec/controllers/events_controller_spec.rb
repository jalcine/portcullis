require 'spec_helper'

describe EventsController do
  before(:each) { login_user }

  describe 'GET index' do; end
  
  describe 'POST create' do
    describe 'uses the provided @event' do
      before(:each) { post :create, event: FactoryGirl.attributes_for(:event) }
      it { expect(assigns(:event)).to be_a Event }
    end

    describe 'persists a new object' do
      subject { FactoryGirl.attributes_for(:event) }
      before(:each) { post :create, event: subject }
      it { expect(Event.find_by_name subject[:name]).to be_a Event }
      it { expect(Event.find_by_address subject[:address]).to be_a Event }
    end
  end

  describe 'GET new' do
    it 'requires authentication' do
      sign_out :user
      get :new
      expect(assigns(:event)).to be_nil
      expect(response.status).to eq(302)
    end

    it 'assigns @event' do
      get :new
      expect(assigns(:event)).to be_a Event
    end

    it 'uses the proper template' do
      get :new
      expect(response).to render_template 'events/new'
    end
  end

  describe 'GET edit' do
    subject { FactoryGirl.create :event }
    describe 'shows the right template' do
      before(:each) { get :edit, id: subject.id }
      it { expect(response).to render_template 'events/edit' }
      it { expect(response).to render_template 'events/_form' }
    end

    describe 'uses the proper event' do
      before(:each) { get :edit, id: subject.id }
      it { expect(assigns(:event)).to be_a Event }
      it { expect(assigns(:event)).to eq subject }
    end

    describe 'ensures authorized user' do
      let(:another_user) { FactoryGirl.create :user }
    end
  end

  describe 'GET show' do
    subject { FactoryGirl.create :event }
    before(:each) { get :show, id: subject.id }
    it 'uses the provided @event' do
      expect(assigns(:event)).to be_a Event
      expect(assigns(:event)).to eq(subject)
    end
    it 'uses the proper template' do
      expect(response).to render_template 'events/show'
    end
  end

  describe 'PATCH/PUT update' do; end

  describe 'DELETE destroy' do; end
end
