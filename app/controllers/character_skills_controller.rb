class CharacterSkillsController < ApplicationController
  def destroy
    @character_skill = CharacterSkill.find(params[:id])
    @character = Character.find(@character_skill.character_id)
    @character_skill.destroy
    @character.save

    respond_to do |format|
      format.html { redirect_to edit_character_path(@character) }
      format.json { head :no_content }
    end
  end
end