require 'spec_helper'

describe EventsController do
  before(:each) { login_user }

  describe 'GET index' do
    it 'handles a bunch of events' do
      4.times.each { FactoryGirl.create :event }
      get :index
      expect(assigns(:events)).to_not be_nil
      expect(assigns(:events)).to_not be_empty
    end
  end

  describe 'POST create' do
    describe 'persists a new event' do
      before(:each) { controller.current_user.grant :host }
      before(:each) { post :create, event: attributes_for(:event, :with_tickets) }
      after(:each) { controller.current_user.revoke :host }
      it { expect(response).to redirect_to(event_path(assigns(:event))) }
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
      it { expect(response).to render_template 'events/new' }
      it { expect(response).to render_template 'events/_form' }
    end
  end

  describe 'GET edit' do
    describe 'user owns' do
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

    describe 'user does not owns' do
      subject { FactoryGirl.create :event, owner: FactoryGirl.create(:user, :host) }
      before(:each) do
        get :edit, id: subject.id
      end

      it { expect(response).to be_a_redirect }
    end
  end

  describe 'GET show' do
    describe 'normal behavior' do
      subject { create :event }
      before(:each) { get :show, id: subject.id }

      it { expect(assigns(:event)).to be_a Event }
      it { expect(response).to render_template 'events/show' }
    end

    describe 'locks password-protected events' do
      subject { create :event, :protected, owner: create(:user, :host) }
      before(:each) do 
        controller.current_user.revoke :host, subject
        subject.password = Faker::Lorem.word
        get :show, id: subject.id
      end

      xit { expect(response).to render_template 'events/_gate' }
      xit { expect(response.status).to eq(401) }
    end

    describe 'includes tickets' do
      subject { create :event, :with_tickets }
      before(:each) { get :show, id: subject.id }
      it { expect(response).to render_template 'tickets/_stub_list' }
      it { expect(response).to render_template 'tickets/_stub' }
    end
  end

  @wip
  describe 'PATCH/PUT update' do
    subject { create :event }

    describe 'updates own evet' do
      before(:each) do
        controller.current_user.grant :host, subject
        put :update, id: subject.id, event: attributes_for(:event)
      end

      it { expect(assigns(:event)).to be_a Event }
      it { expect(response).to be_a_redirect }
    end

    describe 'updates other event' do
      before(:each) do
        controller.current_user.revoke :host, subject
        put :update, id: subject.id, event: attributes_for(:event)
      end

      it { expect(assigns(:event)).to be_a Event }
      it { expect(response).to be_a_redirect }
    end
  end

  describe 'DELETE destroy' do; end
end
