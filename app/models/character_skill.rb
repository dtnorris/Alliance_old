class CharacterSkill < ActiveRecord::Base
  attr_accessible :character_id, :skill_id, :bought, :amount

  belongs_to :character
  belongs_to :skill

  before_save :update_spent_build

  def self.add_or_update_skill(character_id, skill_id)
    skill = CharacterSkill.find_by_skill_id_and_character_id(skill_id, character_id)
    if skill && skill.amount
      skill.amount +=1
      skill.save
      return
    elsif skill && skill.bought
      return
    end
    if skill_id != 0
      char_skill = Skill.find(skill_id).skill_type
      if char_skill == 'int'
        CharacterSkill.create :character_id => character_id, :skill_id => skill_id, :amount => 1
      elsif char_skill == 'bol'
        CharacterSkill.create :character_id => character_id, :skill_id => skill_id, :bought => true
      end
    end
  end

  def update_spent_build
    char = Character.find(character_id)
    if char
      char.calculate_spent_build
      char.save
    end
  end

end
