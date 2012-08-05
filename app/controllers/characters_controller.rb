class CharactersController < ApplicationController
  load_and_authorize_resource
  # GET /characters
  # GET /characters.json
  def index
    if params[:chapter_id]
      @chapter = Chapter.find(params[:chapter_id])
    elsif params[:q] and params[:q][:chapter_id]
      @chapter = Chapter.find(params[:q][:chapter_id])
      params[:q].delete('chapter_id')
    end
    @search = Character.search(params[:q])
    @characters = @search.result
    if @chapter
      @characters = @characters.inject([]) { |a,c| a << c if c.home_chapter == @chapter.id; a }
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
    @xp_tracks = XpTrack.find_all_by_character_id(@character.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character }
    end
  end

  # GET /characters/1/edit
  def edit
    @user = User.find(@character.user_id)
    @chapter = Chapter.find(@character.home_chapter)
    @chapters = @user.members.inject([]) { |arr,m| arr << Chapter.find(m.chapter_id); arr }
  end

  # POST /characters
  # POST /characters.json
  def create
    @character.build_points = 15
    @character.spent_build = 0
    @character.experience_points = 0
    @character.save

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character, notice: 'Character was successfully created.' }
        format.json { render json: @character, status: :created, location: @character }
      else
        format.html { render action: "new" }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /characters/1
  # PUT /characters/1.json
  def update
    if params[:character][:new_skill] != ""
      CharacterSkill.add_skill(@character.id, params[:character][:new_skill].to_i)
    end
    if params[:character][:buy_skill] && params[:character][:buy_skill] != ""
      purchase_ret = CharacterSkill.purchase_skill(@character.id, Skill.find_by_name(params[:character][:buy_skill]).id)
      if purchase_ret == "Pre-requisites are not met to purchase this skill"
        params[:purchase_error] = purchase_ret
      elsif purchase_ret && purchase_ret.legal_spent_build == "You do not have the necessary build for this update"
        params[:purchase_error] = purchase_ret.legal_spent_build
        purchase_ret = purchase_ret.legal_spent_build
      end
    end
    respond_to do |format|
      if @character.update_attributes(params[:character])
        format.html { redirect_to edit_character_path(@character, purchase_ret), notice: 'Character was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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
