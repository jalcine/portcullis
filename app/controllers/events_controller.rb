class EventsController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy, :new]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    authorize! :read, @event
  end

  # GET /events/1
  # GET /events/1.json
  def show
    authorize! :read, @event
    if @event.access_key.present? and !params.include? :access_key
      respond_to do | format |
        format.html { render 'events/_gate', status: 401 }
        format.js   { render nothing: true,  status: 401 }
        format.json { render nothing: true,  status: 401 }
      end and return
    end
  end

  # GET /events/new
  def new
    @event = Event.create!
    @event.owner = current_user
    current_user.grant :host, @event
    authorize! :create, @event
  end

  # GET /events/1/edit
  def edit
    authorize! :update, @event
  end

  # POST /events
  # POST /events.json
  def create
    authorize! :create, Event
    @event = Event.find(event_params[:id])
    @event.update_attributes event_params

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    authorize! :update, @event
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    unless @event.nil?
      authorize! :destroy, @event
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render nil }
        format.json { render nil }
      end
   end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :date_start,
                                    :date_end, :address, :longitude, 
                                    :latitude, :age_groups, 
                                    :primary_category_id, 
                                    :secondary_category_id, :id)
  end
end
