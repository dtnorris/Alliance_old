class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @in_national_show = true
    if session[:chapter_id_for_new_user]
      session.delete :chapter_id_for_new_user
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @chapter = Chapter.find(@event.chapter_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events_for_chapter/1
  def events_for_chapter
    @chapter = Chapter.find(params[:id])
    @events = Event.find_all_by_chapter_id(@chapter.id)
    @user = User.find(session[:user_id_for_membership])
    @in_user_show = true

    respond_to do |format|
      format.html
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    @chapter = Chapter.find(session[:chapter_id_for_new_user])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @chapter = Chapter.find(session[:chapter_id_for_new_user])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @chapter, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { redirect_to new_event_path, notice: 'Error creating Event, missing required fields.' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1/apply
  def apply
    @event = Event.find(params[:id])
    #TODO refactor into model
    @event.applied = true
    @event.save
    if session[:chapter_id_for_new_user]
      @chapter = Chapter.find(session[:chapter_id_for_new_user])
    end
    respond_to do |format|
      if @event.update_attributes(params[:event])
        if @chapter
          format.html { redirect_to @chapter, notice: 'Event was successfully updated.' }
        else
          format.html { redirect_to events_path, notice: 'Event was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

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
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
