require 'spec_helper'

describe EventsController do
  before(:each) do
    login_user
    controller.current_user.add_role :host
  end

  describe 'GET index' do
    it 'handles a bunch of events' do
      4.times.each { FactoryGirl.create :event }
      get :index
      expect(assigns(:events)).to_not be_nil
      expect(assigns(:events)).to_not be_empty
    end
  end

  describe 'POST create' do
    before(:each) do
      post :create, event: FactoryGirl.create(:event, owner: controller.current_user).to_hash
    end

    describe 'uses the provided @event' do
      it { expect(assigns(:event)).to be_a Event }
    end

    describe 'persists a new event' do
      it { expect(assigns(:event)).to_not be_nil }
      it { expect(assigns(:event)).to_not be_a_new_record }
      it { expect(assigns(:event)).to be_persisted } 
    end
  end

  describe 'GET new' do
    it 'requires authentication' do
      sign_out :user
      get :new
      expect(assigns(:event)).to be_nil
      expect(response.status).to eq(302)
    end

    describe 'proper viewing' do
      before(:each) { get :new }
      it { expect(assigns(:event)).to be_a Event }
      it { expect(assigns(:event)).to_not be_a_new_record }
      it { expect(response).to render_template 'events/new' }
    end
  end

  describe 'GET edit' do
    subject { FactoryGirl.create :event, owner: controller.current_user }
    before(:each) do
      controller.current_user.grant :host, subject
      get :edit, id: subject.id
    end

    describe 'shows the proper template' do
      it { expect(response).to be_success }
      it { expect(response).to_not be_a_redirect }
      it { expect(response).to render_template 'events/edit' }
    end
  end

  describe 'GET show' do
    describe 'normal behavior' do
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

    it 'locks password-protected events' do
      event = create :event, :protected
      get :show, id: event.id
      expect(response).to render_template 'events/_gate'
      expect(response.status).to eq(401)
    end
  end

  describe 'PATCH/PUT update' do; end

  describe 'DELETE destroy' do; end
end
