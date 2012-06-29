class CharacterSkill < ActiveRecord::Base
  attr_accessible :character_id, :skill_id, :bought, :amount

  belongs_to :character
  belongs_to :skill

  before_save :update_spent_build

  def self.all_bought_skills(character)
    all_skills = CharacterSkill.find_all_by_character_id(character.id)
    ret = all_skills.map {|r| Skill.find(r.skill_id).name }
  end

  def self.purchase_skill(character_id, skill_id)
    skill = CharacterSkill.find_by_skill_id_and_character_id(skill_id, character_id)
    if skill && skill.amount
      skill.amount +=1
      skill.save
      return
    elsif skill && skill.bought == false
      skill.bought = true
      skill.save
      return
    end
  end

  def self.add_skill(character_id, skill_id)
    skill = CharacterSkill.find_by_skill_id_and_character_id(skill_id, character_id)
    if skill_id != 0 && !skill
      char_skill = Skill.find(skill_id).skill_type
      if char_skill == 'int'
        CharacterSkill.create :character_id => character_id, :skill_id => skill_id, :amount => 0
      elsif char_skill == 'bol'
        CharacterSkill.create :character_id => character_id, :skill_id => skill_id, :bought => false
      end
    end
  end

  def update_spent_build
    if character_id
      char = Character.find(character_id)
      if char
        char.calculate_spent_build
        char.save
      end
    end
  end

end
