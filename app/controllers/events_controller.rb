class EventsController < ApplicationController
  load_and_authorize_resource

  # GET /events
  # GET /events.json
  def index
    if params[:chapter_id]
      @chapter = Chapter.find(params[:chapter_id])
    elsif params[:q] and params[:q][:chapter_id]
      @chapter = Chapter.find(params[:q][:chapter_id])
      params[:q].delete('chapter_id')
    end
    @search = Event.search(params[:q])
    @events = @search.result
    if @chapter
      @events = @search.result.inject([]) {|a,e| a << e if e.chapter_id == @chapter.id; a }
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
    @chapter = @event.chapter
    if @event.event_type_id == 3
      @event.name = Date::MONTHNAMES[@event.date.month] + ' Monthly Goblin Blanket'
    end

    respond_to do |format|
      if @event.save
        if @event.event_type_id == 3 #Hard coded ID of Goblin Blankets
          @stamp_characters = @chapter.members.inject([]) { |arr,m| arr << Character.find(m.character_id) if m.character_id and m.blanket_list; arr }
          @stamp_characters.each do |c|
            Attendee.create(character_id: c.id, event_id: @event.id, applied: false, pc: false)
          end
          format.html { redirect_to chapter_path(@chapter.id), notice: 'Blanket was successfully created'}
        else
          format.html { redirect_to chapter_events_path(@chapter), notice: 'Event was successfully created.' }
          format.json { render json: @event, status: :created, location: @event }
        end
      else
        flash[:error] = 'Error creating Event, missing required fields.'
        format.html { redirect_to new_chapter_event_path(@chapter) }
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
          flash[:error] = 'Error applying event blanket'
          format.html { redirect_to chapter_event_path(@chapter.id,@event.id) }
        end
      elsif @event.update_attributes(params[:event])
        if @event_apply
          if @event.event_type_id == 3
            format.html { redirect_to @chapter, notice: 'Monthly Blanket applied' }
          else
            format.html { redirect_to chapter_events_path(@chapter.id), notice: 'Event was successfully applied' }
          end
        else
          flash[:error] = 'Error applying event'
          format.html { redirect_to chapter_events_path(@chapter.id) }
        end
      else
        flash[:error] =  'Error applying event'
        format.html { redirect_to chapter_events_path(@chapter.id) }
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
