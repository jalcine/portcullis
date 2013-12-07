class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_event
  before_filter :set_ticket, except: [:new]

  def new
    @ticket = Ticket.new
    @ticket.event = @event
    render layout: nil
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
      end
    end
  end

  private
    def set_event
      @event = Event.find params[:event_id] if params.include? :event_id
      @event = Event.find params['event_id'] if params.include? 'event_id'
      Rails.logger.debug @event
    end

    def set_ticket
      @ticket = Ticket.find params[:id] if params.include? :id
      @ticket = Ticket.find params['id'] if params.include? 'id'
      Rails.logger.debug @ticket
    end

    def ticket_params
      params.require(:ticket).permit(:name, :description,
        :date_start, :date_end, :quantity, :max_quantity)
    end
end
