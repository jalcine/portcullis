class OrdersController < ApplicationController
  before_action :set_ticket, except: [:update, :edit]
  before_action :set_order, except: [:new, :create]

  def new
    authorize! :order, @ticket
  end

  def create
    authorize! :order, @ticket

    @order = Order.new order_params
    @order.ticket = @ticket
    @order.user = current_user
    saved_order = @order.save

    respond_to do | format |
      if saved_order
        format.html { redirect_to order_url(@order) }
        format.json { render json: @order, status: 500 }
      else
        format.html { redirect_to new_order_url(@order), status: 500 }
        format.json { render json: @order.errors, status: 500 }
      end
    end
  end

  def destroy
    authorize! :cancel, @order
    @order.destroy!
    redirect_to event_ticket_path(@event, @ticket)
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
        format.html { redirect_to new_order_url(@order), status: 500 }
        format.json { render json: @order.errors, status: 500 }
      end
    end
  end

  def show
    authorize! :show, @order
  end

  private
    def set_ticket
      @ticket = Ticket.find params[:ticket] if params.include? :ticket
    end

    def set_order
      @order = Order.find params[:id] if params.include? :id
    end

    def order_params
      params.require(:order).permit(:quantity, :charge)
    end
end
