require 'spec_helper'

describe OrdersController do
  describe 'as a host' do
    pending 'test for hosts'
  end

  describe 'as a guest' do
    pending 'test for guests'
  end

  describe 'as an attendee' do
    before(:each) { login_user(create(:user, :attendee))}
    [:priced, :donation, :free].each do | price_point |
      describe "with #{price_point} ticket" do
        let(:ticket) { create(:ticket, price_point) }

        describe 'POST create' do
          let(:ticket) { create(:ticket, price_point, event: create(:event)) }
          before(:each) do
            post :create, { ticket_id: ticket.id, order:
                { quantity: ticket.max_quantity } }
          end

          it { expect(assigns(:ticket)).to eq(ticket) }
          it { expect(assigns(:order)).to be_a_kind_of(Order) }
          it { expect(assigns(:order)).to have(:no).errors }
          it { expect(response.status).to eql(302) }
          it { expect(response).to_not redirect_to(root_path) }
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
          let(:order) { create(:order, ticket: create(:ticket, :available)) }
          before(:each) do
            order.user = controller.current_user
            order.save!
            delete :destroy, id: order
          end

          it { expect(assigns(:order)).to eq(order) }
          it { expect(assigns(:order)).to be_destroyed }
        end
      end
    end
  end
end
