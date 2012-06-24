class CharacterSkill < ActiveRecord::Base
  attr_accessible :character_id, :skill_id, :bought, :amount

  belongs_to :character
  belongs_to :skill

  def self.add_or_update_skill(character_id, skill_id)
    skill = CharacterSkill.find_by_skill_id_and_character_id(skill_id, character_id)
    if skill && skill.amount
      skill.amount +=1
      skill.save
      return
    elsif skill && skill.bought
      return
    end
    if Skill.find(skill_id).skill_type == 'int'
      CharacterSkill.create :character_id => character_id, :skill_id => skill_id, :amount => 1
    elsif Skill.find(skill_id).skill_type == 'bol'
      CharacterSkill.create :character_id => character_id, :skill_id => skill_id, :bought => true
    end
  end

end
