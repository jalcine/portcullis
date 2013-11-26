class Events::TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
    @ticket.event = Event.find params[:event_id]
    render 'tickets/form'
  end

  def create
  end
end
