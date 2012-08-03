class AttendeesController < ApplicationController
  load_and_authorize_resource :except => [:show, :create]

  # GET /attendees/1
  # GET /attendees/1.json
  def show
    @user = User.find(params[:id])
    #@attendees = @user.all_attendees
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
          format.html { redirect_to chapter_event_path(@chapter.id,@event.id), notice: 'attendee successfully added to the event' }
        else
          format.html { redirect_to attendee_path(@user.id), notice: 'attendee was successfully created.' }
          format.json { render json: @attendee, status: :created, location: @attendee }
        end
      else
        if @chapter
          format.html { redirect_to chapter_event_path(@chapter.id,@event.id), notice: 'attendee not successfuly added' }
        else
          format.html { redirect_to attendee_path(@user.id), notice: 'attendee not successfully added' }
          format.json { render json: @attendee, status: :unprocessable_entity }
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
