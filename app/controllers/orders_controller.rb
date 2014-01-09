class OrdersController < ApplicationController
  before_action :set_ticket, except: [:update, :edit, :compose]
  before_action :set_order, except: [:new, :create, :compose]

  def compose
    authorize! :order, Ticket
    render partial: 'orders/compose', template: nil
  end

  def create
    authorize! :create, Order

    @order = Order.new order_params
    @order.ticket = @ticket
    @order.user = current_user
    saved_order = @order.save

    respond_to do | format |
      if saved_order
        format.html { redirect_to @order }
        format.json { render json: @order, status: 200 }
      else
        format.html { redirect_to new_ticket_order_url(@ticket), status: 500 }
        format.json { render json: @order.errors, status: 500 }
      end
    end
  end

  def destroy
    authorize! :cancel, @order
    @event = @order.ticket.event
    @order.destroy!
    redirect_to @event
  end

  def edit
    authorize! :update, @order
  end

  def update
    authorize! :update, @order
    saved_order = @order.update_attributes order_params

    Rails.logger.debug "ERRORS: #{@order.errors}"

    respond_to do | format |
      if saved_order
        format.html { redirect_to order_url(@order) }
        format.json { render json: @order, status: 500 }
      else
        format.html { redirect_to edit_order_url(@order), status: 500 }
        format.json { render json: @order.errors, status: 500 }
      end
    end
  end

  def show
    authorize! :read, @order
  end

  private
    def set_ticket
      @ticket = Ticket.find params[:ticket_id] if params.include? :ticket_id
    end

    def set_order
      @order = Order.find params[:id] if params.include? :id
    end

    def order_params
      params.require(:order).permit(:quantity, :charge)
    end
end
