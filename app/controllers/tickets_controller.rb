class TicketsController < ApplicationController
  #before_action :authenticate_user!

  def new
    @ticket = Ticket.new
    @ticket.event = event
    render nothing: true
  end

  def create
    @ticket = Ticket.create ticket_params
    @ticket.event = event
    render nothing: true
  end

  private
    def event
      Event.find params[:event_id]
    end

    def ticket_params
      params.require(:ticket).permit!
    end
end
