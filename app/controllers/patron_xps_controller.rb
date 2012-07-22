class PatronXpsController < ApplicationController
  load_and_authorize_resource :except => [:new_for_chapter, :show, :create]

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
    authorize! :new_for_chapter, @patron_xp

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patron_xp }
    end
  end

  # GET /patron_xps/1
  # GET /patron_xps/1.json
  def show
    @user = User.find(params[:id])
    @patron_xps = @user.all_patron_xps
    authorize! :read, @patron_xps.first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @patron_xps }
    end
  end

  # POST /patron_xps
  # POST /patron_xps.json
  def create
    @user = User.find(params[:patron_xp][:user_id]) unless session[:user_id_for_membership]
    @user = User.find(session[:user_id_for_membership])
    params[:patron_xp].delete("user_id")
    params[:patron_xp][:event_id] = session[:event_id_for_new_patron_xp] if session[:event_id_for_new_patron_xp]
    params[:patron_xp][:event_id] = session[:event_id_for_single_blanket] unless params[:patron_xp][:event_id]
    @patron_xp = PatronXp.new(params[:patron_xp])
    @event = Event.find(@patron_xp.event_id)
    authorize! :new_for_chapter, @patron_xp

    respond_to do |format|
      if @patron_xp.save
        if session[:event_id_for_single_blanket]
          format.html { redirect_to @event, notice: 'Patron successfully added to the event' }
        else
          format.html { redirect_to for_user_patron_xp_path(@user.id), notice: 'Patron xp was successfully created.' }
          format.json { render json: @patron_xp, status: :created, location: @patron_xp }
        end
      else
        if session[:event_id_for_single_blanket]
          format.html { redirect_to @event, notice: 'Patron not successfuly added' }
        else
          format.html { redirect_to new_for_chapter_patron_xp_path(@event.id), notice: 'Patron xp not successfully added' }
          format.json { render json: @patron_xp.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /patron_xps/1
  # DELETE /patron_xps/1.json
  def destroy
    @patron_xp.destroy

    respond_to do |format|
      format.html { redirect_to patron_xps_url }
      format.json { head :no_content }
    end
  end

  # PUT /patron_xps/1
  # PUT /patron_xps/1.json
  # def update
  #   respond_to do |format|
  #     if @patron_xp.update_attributes(params[:patron_xp])
  #       format.html { redirect_to @patron_xp, notice: 'Patron xp was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @patron_xp.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # GET /patron_xps/1/edit
  # def edit
  #   @patron_xp = PatronXp.find(params[:id])
  # end

  # GET /patron_xps
  # GET /patron_xps.json
  # def index
  #   @patron_xps = PatronXp.all

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @patron_xps }
  #   end
  # end

  # GET /patron_xps/new
  # GET /patron_xps/new.json
  # def new
  #   @patron_xp = PatronXp.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @patron_xp }
  #   end
  # end
  
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
