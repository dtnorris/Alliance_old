class EventsController < ApplicationController
  load_and_authorize_resource

  # GET /events
  # GET /events.json
  def index
    if params[:chapter_id]
      @chapter = Chapter.find(params[:chapter_id])
      @events = @chapter.events
      if params[:user_id]
        @user = User.find(params[:user_id])
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @chapter = Chapter.find(params[:chapter_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # POST /events
  # POST /events.json
  def create
    @chapter = params[:event][:chapter_id]

    respond_to do |format|
      if @event.save
        format.html { redirect_to chapter_events_path(@chapter), notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { redirect_to chapter_events_path(@chapter), notice: 'Error creating Event, missing required fields.' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @chapter = Chapter.find(@event.chapter_id)
    @users = @chapter.users
    @attendees = @event.attendees
    @event_type = EventType.find(@event.event_type_id)
    @attendee = Attendee.new
    if params[:user_id]
      @user = User.find(params[:user_id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # # PUT /events/1
  # # PUT /events/1.json
  def update
    @chapter = Chapter.find(params[:chapter_id])
    if params[:character_id]
      @character = Character.find(params[:character_id])
      @attendee = Attendee.find_by_event_id_and_character_id(@event.id, @character.id)
    else
      @event_apply = @event.apply_blanket
    end

    respond_to do |format|
      if @attendee
        if @attendee.apply_event
          format.html { redirect_to chapter_event_path(@chapter.id,@event.id), notice: 'Single Blanket successfully applied' }
        else
          format.html { redirect_to chapter_event_path(@chapter.id,@event.id), notice: 'Error applying event blanket' }
        end
      elsif @event.update_attributes(params[:event])
        if @event_apply
          format.html { redirect_to chapter_events_path(@chapter.id), notice: 'Event was successfully updated' }
        else
          format.html { redirect_to chapter_events_path(@chapter.id), notice: 'Error applying event' }
        end
      else
        format.html { redirect_to chapter_events_path(@chapter.id), notice: 'Error applying event' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /events/1/edit
  # def edit
  # end

  # DELETE /events/1
  # DELETE /events/1.json
  # def destroy
  #   @event.destroy

  #   respond_to do |format|
  #     format.html { redirect_to events_url }
  #     format.json { head :no_content }
  #   end
  # end
end
