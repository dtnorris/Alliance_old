class ChaptersController < ApplicationController
  load_and_authorize_resource
  
  # GET /chapters
  # GET /chapters.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chapters }
    end
  end

  # GET /chapters/new
  # GET /chapters/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chapter }
    end
  end

  # POST /chapters
  # POST /chapters.json
  def create
    respond_to do |format|
      if @chapter.save
        format.html { redirect_to @chapter, notice: 'Chapter was successfully created.' }
        format.json { render json: @chapter, status: :created, location: @chapter }
      else
        format.html { render action: "new" }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
    @blanket_list = true if params[:tab] == 'list'
    @old_blankets = true if params[:tab] == 'old'
    if params[:tab] == 'new'
      @event = Event.new
      @goblin_blanket = EventType.find_by_name('Goblin Blanket').id
      @new_blanket = true
    end

    @events        = @chapter.events
    @members       = @chapter.members
    @users         = @chapter.users
    @characters    = @chapter.characters
    @goblin_events = @events.inject([]) { |arr,e| arr << e if EventType.find(e.event_type_id).name == 'Goblin Blanket'; arr }

    respond_to do |format|
      format.html 
      format.json { render json: @chapter }
    end
  end

  # GET /chapters/1/edit
  def edit
  end

  # PUT /chapters/1
  # PUT /chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update_attributes(params[:chapter])
        format.html { redirect_to @chapter, notice: 'Chapter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  # def destroy
  #   @chapter.destroy
    
  #   respond_to do |format|
  #     format.html { redirect_to chapters_url }
  #     format.json { head :no_content }
  #   end
  # end
end
