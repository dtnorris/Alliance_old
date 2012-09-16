class CharacterSkillsController < ApplicationController
  load_and_authorize_resource :except => [:create]

  def create
    @chapter = Chapter.find(params[:character_skill][:chapter_id]) if params[:character_skill][:chapter_id]
    @character = Character.find(params[:character_skill][:character_id].to_i)
    if params[:character_skill][:other] != ''
      type = params[:character_skill][:other].to_i
    elsif params[:character_skill][:race] != ''
      type = params[:character_skill][:race].to_i
    elsif params[:character_skill][:weapon] != ''
      type = params[:character_skill][:weapon].to_i
    elsif params[:character_skill][:specialty] != ''
      type = params[:character_skill][:specialty].to_i
    elsif params[:character_skill][:spells] != ''
      type = params[:character_skill][:spells].to_i
    end
    authorize! :create, @character_skill
    respond_to do |format|
      if type
        CharacterSkill.add_skill(@character.id, type) 
        flash[:notice] = 'Skill successfully added.'
        if @chapter
          format.html { redirect_to edit_chapter_character_path(@chapter, @character) }
        else
          format.html { redirect_to edit_character_path(@character) }
        end
      else
        flash[:error] = 'No skill selected.'
        if @chapter
          format.html {redirect_to edit_chapter_character_path(@chapter, @character) }
        else
          format.html { redirect_to edit_character_path(@character) }
        end
      end
    end
  end

  def update
    @character = @character_skill.character
    purchase_ret = CharacterSkill.purchase_skill(@character_skill)
    respond_to do |format|
      if !purchase_ret
        flash[:error] = 'Pre-requisites are not met to purchase this skill'
      elsif !purchase_ret.legal_spent_build
        if @character_skill.amount
          @character_skill.amount -= 1
          if @character_skill.skill.name == 'Weapon Proficiency'
            ca = CharacterSkill.find_by_character_id_and_skill_id(@character.id, Skill.find_by_name('Critical Attack').id)
            ca.amount = 4
            ca.save
          elsif @character_skill.skill.name == 'Backstab'
            ca = CharacterSkill.find_by_character_id_and_skill_id(@character.id, Skill.find_by_name('Back Attack').id)
            ca.amount = 4
            ca.save
          end
        elsif @character_skill.bought
          @character_skill.bought = false
        end
        @character_skill.save
        flash[:error] = 'You do not have the necessary build for this update'
      else
        flash[:notice] = 'Character was successfully updated.'
      end
      format.html { redirect_to edit_chapter_character_path(@character.chapter, @character) }
    end
  end

  def destroy
    @character = @character_skill.character
    if @character_skill.amount and @character_skill.amount > 0
      @character_skill.amount -= 1
      @character_skill.save
    elsif @character_skill.bought 
      @character_skill.bought = false
      @character_skill.save
    else
      @character_skill.destroy
    end
    @character.save

    respond_to do |format|
      format.html { redirect_to edit_character_path(@character), notice: 'Skill Removed' }
      format.json { head :no_content }
    end
  end
end