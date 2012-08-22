class CharactersController < ApplicationController
  load_and_authorize_resource
  # GET /characters
  # GET /characters.json
  def index
    authorize! :index, Ability
    if params[:chapter_id]
      @chapter = Chapter.find(params[:chapter_id])
    elsif params[:q] and params[:q][:chapter_id]
      @chapter = Chapter.find(params[:q][:chapter_id])
      params[:q].delete('chapter_id')
    end
    @search = Character.search(params[:q])
    @characters = @search.result
    if @chapter
      @characters = @characters.inject([]) { |a,c| a << c if c.chapter_id == @chapter.id; a }
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @characters }
    end
  end

  # GET /characters/1/new
  def new
    @character = Character.new
    @chapter = Chapter.find(params[:chapter_id])
    @user = User.find(params[:user_id])
    @chapters = @user.members.inject([]) { |arr,m| arr << Chapter.find(m.chapter_id); arr }

    respond_to do |format|
      format.html
      format.json {render json: @character}
    end
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @user = User.find(params[:user_id]) if params[:user_id]
    @chapter = Chapter.find(params[:chapter_id]) if params[:chapter_id]
    @deaths = @character.deaths
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character }
      format.pdf do
        pdf = CharacterPdf.new(@character)
        send_data pdf.render, filename: "Character_#{@character.name}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  # GET /characters/1/xp_track
  def xp_track
    @user = User.find(params[:user_id]) if params[:user_id]
    @chapter = Chapter.find(params[:chapter_id]) if params[:chapter_id]
    @xp_tracks = XpTrack.find_all_by_character_id(@character.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character }
    end
  end

  # GET /characters/1/edit
  def edit
    @user = User.find(params[:user_id]) if params[:user_id]
    @chapter = Chapter.find(params[:chapter_id]) if params[:chapter_id]
    @chapters = @character.user.members.inject([]) { |arr,m| arr << [m.chapter.name, m.chapter.id]; arr }
    @death = Death.new
    @character_skill = CharacterSkill.new
  end

  # POST /characters
  # POST /characters.json
  def create
    @chapter = @character.chapter
    @user = @character.user
    @character.build_points = 15
    @character.spent_build = 0
    @character.experience_points = 0
    @character.save

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character, notice: 'Character was successfully created.' }
        format.json { render json: @character, status: :created, location: @character }
      else
        flash[:error] = 'Error creating character.'
        format.html { redirect_to new_chapter_user_character_path(@chapter, @user) }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /characters/1
  # PUT /characters/1.json
  def update
    respond_to do |format|
      if @character.update_attributes(params[:character])
        format.html { redirect_to edit_character_path(@character), notice: 'Character was successfully updated' }
        format.json { head :no_content }
      else
        flash[:error] = 'Error updating character.'
        format.html { redirect_to edit_character_path(@character) }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  # def destroy
  #   @character.destroy

  #   respond_to do |format|
  #     format.html { redirect_to characters_url }
  #     format.json { head :no_content }
  #   end
  # end

  # def xp_mod_day
  #   @character = Character.find(params[:id])
  #   xp = @character.add_xp(0.5, 'Mod Day')
  #   xp.attendee_id = 1
  #   xp.save

  #   respond_to do |format|
  #     format.html { redirect_to xp_track_character_path(@character) }
  #     format.json { render json: @characters }
  #   end
  # end

  # def xp_one_day
  #   @character = Character.find(params[:id])
  #   xp = @character.add_xp(1, 'One Day')
  #   xp.attendee_id = 1
  #   xp.save

  #   respond_to do |format|
  #     format.html { redirect_to xp_track_character_path(@character) }
  #     format.json { render json: @characters }
  #   end
  # end

  # def xp_weekend
  #   @character = Character.find(params[:id])
  #   xp = @character.add_xp(2, 'Weekend')
  #   xp.attendee_id = 1
  #   xp.save

  #   respond_to do |format|
  #     format.html { redirect_to xp_track_character_path(@character) }
  #     format.json { render json: @characters }
  #   end
  # end

  # def xp_long_weekend
  #   @character = Character.find(params[:id])
  #   xp = @character.add_xp(3, 'Long Weekend')
  #   xp.attendee_id = 1
  #   xp.save

  #   respond_to do |format|
  #     format.html { redirect_to xp_track_character_path(@character) }
  #     format.json { render json: @characters }
  #   end
  # end
end
