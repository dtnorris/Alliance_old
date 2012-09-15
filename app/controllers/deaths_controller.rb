class DeathsController < ApplicationController
  load_and_authorize_resource

  # GET /deaths
  # GET /deaths.json
  def index
    if params[:chapter_id]
      @chapter = Chapter.find(params[:chapter_id])
    end
    if params[:character_id]
      @character = Character.find(params[:character_id])
      @deaths = @deaths.inject([]) { |a,d| a << d if d.character_id == @character.id; a }
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deaths }
    end
  end

  # POST /deaths
  # POST /deaths.json
  def create
    @chapter = Chapter.find(session[:chapter_id]) if session[:chapter_id]
    session[:chapter_id] = nil
    if @death.buyback 
      notice = 'Death buyback was successfully created'
    elsif @death.regen_css
      notice = 'Regen/CSS Death was successfully created'
    else
      notice = 'Death was successfully created'
    end
    respond_to do |format|
      if @death.save
        if @chapter
          format.html { redirect_to edit_chapter_character_path(@death.chapter_id, @death.character_id), notice: notice }
        else
          format.html { redirect_to edit_character_path(@death.character_id), notice: notice }
        end
      else
        flash[:error] = 'Death not created'
        if @chapter
          format.html { redirect_to edit_chapter_character_path(@death.chapter_id, @death.character_id), notice: notice }
        else
          format.html { redirect_to edit_character_path(@death.character_id), notice: notice }
        end
      end
    end
  end

  # DELETE /deaths/1
  # DELETE /deaths/1.json
  def destroy
    @character = Character.find(@death.character_id)
    @death.destroy

    respond_to do |format|
      format.html { redirect_to character_deaths_path(@character.id), notice: 'Death removed' }
      format.json { head :no_content }
    end
  end

  # GET /deaths/1
  # GET /deaths/1.json
  # def show
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @death }
  #   end
  # end

  # GET /deaths/new
  # GET /deaths/new.json
  # def new
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @death }
  #   end
  # end

  # GET /deaths/1/edit
  # def edit
  # end

  # PUT /deaths/1
  # PUT /deaths/1.json
  # def update
  #   respond_to do |format|
  #     if @death.update_attributes(params[:death])
  #       format.html { redirect_to @death, notice: 'Death was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @death.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
end
