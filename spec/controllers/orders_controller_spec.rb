require 'spec_helper'

describe OrdersController do
  describe 'as an attendee' do
    before(:each) { login_user(create(:user, :attendee))}
    let(:ticket) { create(:ticket) }

    describe 'GET new', broken: true do
      before(:each) { get :new }
      it { expect(assigns(:ticket)).to eq(ticket) }
      it { expect(response.code).to eql(200) }
      it { expect(response).to render_template 'orders/_form' }
      it { expect(response).to render_template 'tickets/_slip' }
    end

    describe 'POST create' do
      before(:each) { post :create, ticket: ticket.id, order: { quantity: ticket.max_quantity } }

      it { expect(assigns(:ticket)).to eq(ticket) }
      it { expect(assigns(:order)).to have(:no).errors }
      it { expect(response.status).to eql(302) }
      it { expect(response).to redirect_to(order_path(assigns(:order))) }
    end

    describe 'GET show' do
      let(:order) { create(:order, ticket: ticket) }
      before(:each) { get :show, id: order }
      it { expect(assigns(:order)).to eq(order) }
      it { expect(response.status).to eql(302) }
      xit { expect(response).to render_template 'tickets/slip' }
    end

    describe 'GET edit', broken: true do
      let(:order) { create(:order, ticket: ticket) }
      before(:each) { get :edit, id: order }
      it { expect(assigns(:ticket)).to eq(ticket) }
      it { expect(assigns(:order)).to eq(order) }
      it { expect(response).to render_template 'tickets/_slip' }
      it { expect(response).to render_template 'orders/_form' }
    end

    describe 'PATCH/PUT update', broken: true do
      let(:order) { create(:order, ticket: ticket) }
      before(:each) { put :update, { id: order.id, order: attributes_for(:order).extract!(:quanity) } }

      it { expect(assigns(:ticket)).to eq(ticket) }
      it { expect(assigns(:order)).to eq(order) }
      it { expect(assigns(:order)).to have(:no).errors }
      it { expect(response).to redirect_to(order_path(order)) }
    end

    describe 'DELETE destroy' do
      let(:order) { create(:order, ticket: ticket) }
      before(:each) { delete :destroy, id: order }

      it { expect(assigns(:order)).to eq(order) }
      xit { expect(order).to be_destroyed }
    end
  end
end
