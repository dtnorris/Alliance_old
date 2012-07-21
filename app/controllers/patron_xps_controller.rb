class PatronXpsController < ApplicationController
  # GET /patron_xps
  # GET /patron_xps.json
  def index
    @patron_xps = PatronXp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @patron_xps }
    end
  end

  # GET /patron_xps/new
  # GET /patron_xps/new.json
  def new
    @patron_xp = PatronXp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patron_xp }
    end
  end

  # GET /patron_xps/1/new_for_chapter
  def new_for_chapter
    @patron_xp = PatronXp.new
    @user = User.find(session[:user_id_for_membership])
    @characters = Character.find_all_by_user_id(@user.id)
    @event = Event.find(params[:id])
    @chapter = Chapter.find(@event.chapter_id)
    session[:chapter_id_for_new_patron_xp] = @chapter.id
    session[:event_id_for_new_patron_xp] = @event.id
    session.delete :event_id_for_single_blanket if session[:event_id_for_single_blanket]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patron_xp }
    end
  end

  def for_user
    @user = User.find(params[:id])
    @patron_xps = @user.all_patrons_xps

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patron_xp }
    end
  end

  # GET /patron_xps/1/edit
  # def edit
  #   @patron_xp = PatronXp.find(params[:id])
  # end

  # POST /patron_xps
  # POST /patron_xps.json
  def create
    @patron_xp = PatronXp.new(params[:patron_xp])
    @patron_xp.event_id = session[:event_id_for_new_patron_xp] if session[:event_id_for_new_patron_xp]
    @patron_xp.event_id = session[:event_id_for_single_blanket] unless @patron_xp.event_id
    @event = Event.find(@patron_xp.event_id)
    @user = User.find(Character.find(@patron_xp.character_id).user_id)

    respond_to do |format|
      if @patron_xp.save
        if session[:event_id_for_single_blanket]
          format.html { redirect_to @event, notice: 'Patron successfully added to the event' }
        else
          format.html { redirect_to for_user_patron_xp_path(@user.id), notice: 'Patron xp was successfully created.' }
          format.json { render json: @patron_xp, status: :created, location: @patron_xp }
        end
      else
        format.html { redirect_to new_for_chapter_patron_xp_path(@event.id), notice: 'Patron xp not successfully created.' }
        format.json { render json: @patron_xp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /patron_xps/1
  # PUT /patron_xps/1.json
  def update
    @patron_xp = PatronXp.find(params[:id])

    respond_to do |format|
      if @patron_xp.update_attributes(params[:patron_xp])
        format.html { redirect_to @patron_xp, notice: 'Patron xp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @patron_xp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patron_xps/1
  # DELETE /patron_xps/1.json
  def destroy
    @patron_xp = PatronXp.find(params[:id])
    @patron_xp.destroy

    respond_to do |format|
      format.html { redirect_to patron_xps_url }
      format.json { head :no_content }
    end
  end

  
  # GET /patron_xps/1
  # GET /patron_xps/1.json
  # def show
  #   @patron_xp = PatronXp.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @patron_xp }
  #   end
  # end
end
