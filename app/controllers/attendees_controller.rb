class AttendeesController < ApplicationController
  load_and_authorize_resource :except => [:show, :create]

  def index
    @user = User.find(params[:user_id])
    @attendees = @user.all_attendees
    authorize! :update, @user

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attendees }
    end
  end

  # POST /attendees
  # POST /attendees.json
  def create
    if params[:attendee][:chapter_id]
      @chapter = Chapter.find(params[:attendee][:chapter_id])
      params[:attendee].delete('chapter_id')
    end
    @user = User.find(params[:attendee][:user_id])
    params[:attendee].delete('user_id')
    @attendee = Attendee.new(params[:attendee])
    @event = Event.find(@attendee.event_id)
    authorize! :create, @attendee

    respond_to do |format|
      if @attendee.save
        if @chapter
          format.html { redirect_to chapter_event_path(@chapter.id,@event.id), notice: 'Attendee successfully added to the event' }
        else
          format.html { redirect_to user_attendees_path(@user.id), notice: 'Added to event.' }
          format.json { render json: @attendee, status: :created, location: @attendee }
        end
      else
        if @chapter
          format.html { redirect_to chapter_event_path(@chapter.id,@event.id), notice: 'Attendee not successfuly added' }
        else
          format.html { redirect_to attendee_path(@user.id), notice: 'Not successfully added to event.' }
          format.json { render json: @attendee, status: :unprocessable_entity }
        end
      end
    end
  end

end
