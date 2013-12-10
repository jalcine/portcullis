class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_event
  before_filter :set_ticket, except: [:new, :create]

  def new
    @ticket = Ticket.new
    @ticket.event = @event
    render layout: nil
  end

  def show
    respond_to do | format |
      if @ticket.nil?
        format.js { render jbuilder: nil }
        format.html { render nothing: true }
        format.json { render nothing: true }
      else
        format.js { render jbuilder: @ticket }
        format.json { render nothing: true }
        format.html { redirect_to root_url, notice: 'No ticket' }
      end
    end
  end

  def create
    Rails.logger.debug params.to_yaml
    @ticket = Ticket.create ticket_params
    @event.tickets << @ticket

    respond_to do | format |
      if @ticket.save
        format.html { 
          redirect_to event_tickets_url(@event, @ticket),
          notice: 'Ticket was successfully created.'
        }
        format.json {
          render action: 'show',
          location: event_tickets_url(@event, @ticket)
        }
        format.js { render action: 'show' }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket.errors }
        format.js   { render json: @tickets.errors, status: :not_found }
      end
    end
  end

  private
    def set_event
      @event = Event.find params[:event_id]
    end

    def set_ticket
      @ticket = Ticket.find params[:id]
    end

    def ticket_params
      params.require(:ticket).permit(:name, :description, 
        :date_start, :date_end, :quantity, :price)
    end
end
