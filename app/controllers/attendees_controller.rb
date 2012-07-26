class AttendeesController < ApplicationController
  load_and_authorize_resource :except => [:new_for_chapter, :show, :create]

  # GET /attendees/1/new_for_chapter
  def new_for_chapter
    @attendee = Attendee.new
    @user = User.find(session[:user_id_for_membership])
    @characters = Character.find_all_by_user_id(@user.id)
    @event = Event.find(params[:id])
    @chapter = Chapter.find(@event.chapter_id)
    session[:chapter_id_for_new_attendee] = @chapter.id
    session[:event_id_for_new_attendee] = @event.id
    session.delete :event_id_for_single_blanket if session[:event_id_for_single_blanket]
    authorize! :new_for_chapter, @attendee

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attendee }
    end
  end

  # GET /attendees/1
  # GET /attendees/1.json
  def show
    @user = User.find(params[:id])
    @attendees = @user.all_attendees
    #HACKED, this allows a user with no attendees to see a blank page, somewhat hackish
    @attendees = []
    @attendees << @user
    authorize! :read, @attendees.first
    @attendees = @user.all_attendees

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attendees }
    end
  end

  # POST /attendees
  # POST /attendees.json
  def create
    @user = User.find(params[:attendee][:user_id]) unless session[:user_id_for_membership]
    @user = User.find(session[:user_id_for_membership])
    params[:attendee].delete("user_id")
    params[:attendee][:event_id] = session[:event_id_for_new_attendee] if session[:event_id_for_new_attendee]
    params[:attendee][:event_id] = session[:event_id_for_single_blanket] unless params[:attendee][:event_id]
    @attendee = Attendee.new(params[:attendee])
    @event = Event.find(@attendee.event_id)
    authorize! :new_for_chapter, @attendee

    respond_to do |format|
      if @attendee.save
        if session[:event_id_for_single_blanket]
          format.html { redirect_to @event, notice: 'attendee successfully added to the event' }
        else
          format.html { redirect_to attendee_path(@user.id), notice: 'attendee was successfully created.' }
          format.json { render json: @attendee, status: :created, location: @attendee }
        end
      else
        if session[:event_id_for_single_blanket]
          format.html { redirect_to @event, notice: 'attendee not successfuly added' }
        else
          format.html { redirect_to new_for_chapter_attendee_path(@event.id), notice: 'attendee not successfully added' }
          format.json { render json: @attendee.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /attendees/1
  # DELETE /attendees/1.json
  # def destroy
  #   @attendee.destroy

  #   respond_to do |format|
  #     format.html { redirect_to attendees_url }
  #     format.json { head :no_content }
  #   end
  # end

  # PUT /attendees/1
  # PUT /attendees/1.json
  # def update
  #   respond_to do |format|
  #     if @attendee.update_attributes(params[:attendee])
  #       format.html { redirect_to @attendee, notice: 'attendee was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @attendee.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # GET /attendees/1/edit
  # def edit
  #   @attendee = Attendee.find(params[:id])
  # end

  # GET /attendees
  # GET /attendees.json
  # def index
  #   @attendees = Attendee.all

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @attendees }
  #   end
  # end

  # GET /attendees/new
  # GET /attendees/new.json
  # def new
  #   @attendee = Attendee.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @attendee }
  #   end
  # end
  
  # GET /attendees/1
  # GET /attendees/1.json
  # def show
  #   @attendee = Attendee.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @attendee }
  #   end
  # end
end
