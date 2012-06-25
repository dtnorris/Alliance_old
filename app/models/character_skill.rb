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
    if Skill.find(skill_id).skill_type == 'int'
      CharacterSkill.create :character_id => character_id, :skill_id => skill_id, :amount => 1
    elsif Skill.find(skill_id).skill_type == 'bol'
      CharacterSkill.create :character_id => character_id, :skill_id => skill_id, :bought => true
    end
  end

  def update_spent_build
    char = Character.find(character_id)
    if char.char_class
      skill = Skill.find(skill_id)
      class_name = char.char_class.name.downcase << "_cost"
      char.spent_build += skill[class_name]
      char.save
    end
  end

end
