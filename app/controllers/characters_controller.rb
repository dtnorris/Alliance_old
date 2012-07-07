class CharactersController < ApplicationController
  # GET /characters
  # GET /characters.json
  def index
    @characters = Character.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @characters }
    end
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @character = Character.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character }
    end
  end

  def xp_track
    @character = Character.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character }
    end
  end

  # GET /characters/new
  # GET /characters/new.json
  # def new
  #   @character = Character.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @character }
  #   end
  # end

  # GET /characters/1/new_for_user
  def new_for_user
    @character = Character.new
    session[:user_id_for_new_character] = params[:id]

    respond_to do |format|
      format.html
      format.json {render json: @character}
    end
  end

  # GET /characters/1/edit
  def edit
    @character = Character.find(params[:id])
  end

  def xp_mod_day
    @character = Character.find(params[:id])
    @character.add_xp(0.5, 'Mod Day')

    respond_to do |format|
      format.html { redirect_to xp_track_character_path(@character) }
      format.json { render json: @characters }
    end
  end

  def xp_one_day
    @character = Character.find(params[:id])
    @character.add_xp(1, 'One Day')

    respond_to do |format|
      format.html { redirect_to xp_track_character_path(@character) }
      format.json { render json: @characters }
    end
  end

  def xp_weekend
    @character = Character.find(params[:id])
    @character.add_xp(2, 'Weekend')

    respond_to do |format|
      format.html { redirect_to xp_track_character_path(@character) }
      format.json { render json: @characters }
    end
  end

  def xp_long_weekend
    @character = Character.find(params[:id])
    @character.add_xp(3, 'Long Weekend')

    respond_to do |format|
      format.html { redirect_to xp_track_character_path(@character) }
      format.json { render json: @characters }
    end
  end

  # POST /characters
  # POST /characters.json
  def create
    #params[:character].delete(:character_skill)
    #debugger
    @character = Character.new(params[:character])
    @character.user_id = session[:user_id_for_new_character].to_i
    @character.build_points = 15
    @character.spent_build = 0
    @character.experience_points = 0
    @character.save
    session.delete :user_id_for_new_character

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character, notice: 'Character was successfully created.' }
        format.json { render json: @character, status: :created, location: @character }
      else
        format.html { render action: "new_for_user" }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /characters
  # def create_for_user
  #   #debugger
  #   @character = Character.new(params[:character])
  #   @character.user_id = params[:user_id]
  #   @character.build_points = 15
  #   @character.spent_build = 0
  #   @character.experience_points = 0
  #   @character.save

  #   respond_to do |format|
  #     if @character.save
  #       format.html { redirect_to @character, notice: 'Character was successfully created.' }
  #       format.json { render json: @character, status: :created, location: @character }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @character.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /characters/1
  # PUT /characters/1.json
  def update
    @character = Character.find(params[:id])
    if params[:character][:new_skill] != ""
      CharacterSkill.add_skill(@character.id, params[:character][:new_skill].to_i)
    end
    if params[:character][:buy_skill] && params[:character][:buy_skill] != ""
      purchase_ret = CharacterSkill.purchase_skill(@character.id, Skill.find_by_name(params[:character][:buy_skill]).id)
      #debugger
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
  def destroy
    @character = Character.find(params[:id])
    @character.destroy

    respond_to do |format|
      format.html { redirect_to characters_url }
      format.json { head :no_content }
    end
  end
end
