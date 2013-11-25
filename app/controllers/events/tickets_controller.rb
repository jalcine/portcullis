class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
    @ticket.event = Event.find params[:ticket_id]
    render 'tickets/form'
  end

  def create
  end
end
