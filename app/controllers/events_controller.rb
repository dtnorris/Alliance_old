class EventsController < ApplicationController
  load_and_authorize_resource :except => [:apply_to_single_character, :apply]

  # PUT /events/1/apply_to_single_character
  def apply_to_single_character
    @event = Event.find(session[:event_id_for_single_blanket])
    @character = Character.find(params[:id])
    @attendee = Attendee.find_by_event_id_and_character_id(@event.id, @character.id)
    authorize! :apply_to_single_character, @event
    
    respond_to do |format|
      if @attendee.apply_event
        format.html { redirect_to @event, notice: 'Single Blanket successfully applied.' }
      else
        format.html { redirect_to @event, notice: 'Error applying event blanket' }
      end
    end
  end

  # PUT /events/1/apply
  def apply
    @event = Event.find(params[:id])
    @event.apply_blanket
    @chapter = Chapter.find(params[:chapter_id])
    authorize! :apply, @event

    respond_to do |format|
      if @event.update_attributes(params[:event])
        if @chapter
          format.html { redirect_to chapter_events_path(@chapter.id), notice: 'Event was successfully updated.' }
        else
          format.html { redirect_to chapter_events_path(@chapter.id), notice: 'Event was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

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

  # GET /events/1
  # GET /events/1.json
  def show
    @chapter = Chapter.find(@event.chapter_id)
    @members = @chapter.members
    @users = User.all_for_given_members(@members)
    @users = @users.sort_by { |u| u.name }
    @attendee = Attendee.new
    @attendees = Attendee.find_all_by_event_id(@event.id)
    session[:event_id_for_single_blanket] = @event.id
    if params[:user_id]
      @user = User.find(params[:user_id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
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

  # GET /events/1/edit
  def edit
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

  # PUT /events/1
  # PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

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
