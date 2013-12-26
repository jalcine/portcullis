class EventsController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy, :new]
  before_action :set_event, except: [:index, :new, :create]

  # GET /events
  # GET /events.json
  def index
    authorize! :view, Event
    @events = Event.all
  end

  # GET/POST /events/1
  # GET/POST /events/1.json
  def show
    authorize! :view, @event
    if @event.access_key.present?
      valid_key = false
      valid_key = params[:event][:access_key] == @event.access_key if params.include? :event
      if !valid_key 
        respond_to do | format |
          format.html { render 'events/_gate', status: 401 }
          format.js   { render nothing: true,  status: 401 }
          format.json { render nothing: true,  status: 401 }
        end and return
      end
    end
  end

  # GET /events/new
  def new
    @event = Event.create! owner: current_user
    current_user.grant :host, @event
  end

  # GET /events/1/edit
  def edit
    authorize! :edit, @event
  end

  # POST /events
  # POST /events.json
  def create
    authorize! :update, Event
    @event = Event.new event_params
    @event.owner = current_user
    current_user.grant :host, @event
    authorize! :create, @event

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: t('events.create.success') }
        format.json { render action: :show, status: :created, location: @event }
      else
        format.html { render action: :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    authorize! :create, @event

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
    def set_event
      if params.include? :id and params[:id].present?
        @event = Event.includes(:tickets, :owner).find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :date_start, :banner,
        :date_end, :address, :longitude, :latitude, :age_groups, :access_key,
        :primary_category_id, :secondary_category_id)
  end
end
