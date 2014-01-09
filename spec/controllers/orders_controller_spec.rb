require 'spec_helper'

describe OrdersController do
  describe 'as an attendee' do
    before(:each) { login_user(create(:user, :attendee))}
    let(:ticket) { create(:ticket) }

    describe 'POST create' do
      let(:ticket) { create(:ticket, :priced, event: create(:event)) }
      before(:each) { post :create, { ticket_id: ticket.id, order: { quantity: ticket.max_quantity } } }

      it { expect(response).to_not redirect_to(root_path) }
      it { expect(assigns(:ticket)).to eq(ticket) }
      it { expect(assigns(:order)).to be_a_kind_of(Order) }
      it { expect(assigns(:order)).to have(:no).errors }
      it { expect(response.status).to eql(302) }
      it { expect(response).to redirect_to(order_path(assigns(:order))) }
    end

    describe 'GET show' do
      describe 'user own order' do
        let(:order) { create(:order, ticket: ticket, user: controller.current_user) }
        before(:each) { get :show, id: order }
        it { expect(assigns(:order)).to eq(order) }
        it { expect(response.status).to eql(200) }
        it { expect(response).to render_template 'tickets/_slip' }
        it { expect(response).to render_template 'orders/show' }
      end

      describe 'user doesnt own order' do
        let(:order) { create(:order, ticket: ticket, user: create(:user, :attendee)) }
        before(:each) { get :show, id: order }
        it { expect(assigns(:order)).to eq(order) }
        it { expect(response.status).to eql(302) }
        it { expect(response).to redirect_to(root_path) }
      end
    end

    describe 'GET edit', broken: true do
      let(:order) { create(:order, ticket: ticket) }
      before(:each) { get :edit, id: order }
      it { expect(assigns(:ticket)).to eq(ticket) }
      it { expect(assigns(:order)).to eq(order) }
      it { expect(response).to render_template 'tickets/_slip' }
      it { expect(response).to render_template 'orders/_form' }
      it { expect(response).to render_template 'orders/edit' }
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
