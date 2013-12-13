class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_event
  before_filter :set_ticket, except: [:new, :create]

  # DELETE /events/:event_id/tickets/:id
  # TODO: Add actions on destruction.
  def destroy
    @ticket.destroy unless @ticket.nil?
    render nothing: true, status: :moved_permanently
  end

  # GET /events/:event_id/tickets/new
  def new
    @ticket = @event.tickets.build {}
    Rails.logger.debug @ticket
    Rails.logger.debug @event

    respond_to do | format |
      format.html
      format.js { render layout: nil }
    end
  end

  # GET /events/:event_id/tickets/:id
  def show
    respond_to do | format |
      if @ticket.nil?
        format.html
        format.js { render jbuilder: nil }
        format.json { render nothing: true }
      else
        format.js { render jbuilder: @ticket }
        format.json { render nothing: true }
        format.html { redirect_to root_url, notice: 'No ticket' }
      end
    end
  end

  # PUT /events/:event_id/tickets/:id
  def create
    @ticket = Ticket.create ticket_params
    @event.tickets << @ticket

    respond_to do | format |
      if @ticket.save
        format.html { 
          redirect_to event_tickets_url(@event, @ticket),
          notice: 'Ticket was successfully created.',
          status: 200
        }
        format.json {
          render action: :show,
          location: event_tickets_url(@event, @ticket),
          status: 200 
        }
        format.js { 
          render action: :show,
          status: 200
        }
      else
        format.html { render action: :new }
        format.json { render json: @ticket.errors, status: :not_found }
        format.js   { render json: @tickets.errors, status: :not_found }
      end
    end
  end

  # POST /events/:event-id/tickets/:id
  def update 
    @ticket.update_attributes ticket_params 

    respond_to do | format |
      if @ticket.save
        format.html { 
          redirect_to [@event, @ticket],
          notice: 'Ticket was successfully updated.'
        }
        format.json {
          render action: :show,
          location: event_tickets_url(@event, @ticket)
        }
        format.js { render action: :show }
      else
        format.html { redirect_to @ticket, notice: @ticket.errors, status: 500 }
        format.json { render json: @ticket.errors, status: 500 } 
        format.js   { render json: @tickets.errors, status: 500 }
      end
    end
  end

  private
    def set_event
      @event = Event.find params[:event_id]
      Rails.logger.info 'No event passed!' unless params.include? :event_id
    end

    def set_ticket
      @ticket = Ticket.find params[:id]
      Rails.logger.info 'No ticket passed!' unless params.include? :id
    end

    def ticket_params
      params.require(:ticket).permit(:name, :description, 
                                     :date_start, :date_end, :quantity, :price)
    end
end
