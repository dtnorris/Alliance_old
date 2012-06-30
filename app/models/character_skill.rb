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
    if skill && skill.validate_skill_can_be_purchased
      if skill.amount
        skill.amount +=1
        skill.save
        return skill
      elsif skill.bought == false
        skill.bought = true
        skill.save
        return skill
      end
    else
      return "Pre-requisites are not met to purchase this skill"
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

  def validate_skill_can_be_purchased
    skills_arr = CharacterSkill.find_all_by_character_id(self.character_id)
    if Skill.find(self.skill_id).name == 'Alchemy'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Herbal Lore' && sk_check.bought
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Create Potion' 
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Earth Level 1' && sk_check.amount > 0
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Create Scroll'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Celestial Level 1' && sk_check.amount > 0
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Create Trap'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Legerdemain' && sk_check.bought
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Herbal Lore' || Skill.find(self.skill_id).name == 'Read Magic'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Read And Write' && sk_check.bought
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Healing Arts'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'First Aid' && sk_check.bought
          skills_arr.each do |sk_check_2|
            if Skill.find(sk_check_2.skill_id).name == 'Read And Write' && sk_check_2.bought
              return true
            end
          end
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Style Master' || Skill.find(self.skill_id).name == 'Back Attack' || Skill.find(self.skill_id).name == 'Critical Attack'
      skills_arr.each do |sk_check|
        if (Skill.find(sk_check.skill_id).name == 'Archery' && sk_check.bought) || 
          (Skill.find(sk_check.skill_id).name == 'One Handed Blunt' && sk_check.bought) || 
          (Skill.find(sk_check.skill_id).name == 'One Handed Edged' && sk_check.bought) || 
          (Skill.find(sk_check.skill_id).name == 'One Handed Master' && sk_check.bought) || 
          (Skill.find(sk_check.skill_id).name == 'Polearm' && sk_check.bought) || 
          (Skill.find(sk_check.skill_id).name == 'Small Weapon' && sk_check.bought) || 
          (Skill.find(sk_check.skill_id).name == 'Staff' && sk_check.bought) || 
          (Skill.find(sk_check.skill_id).name == 'Thrown Weapon' && sk_check.bought) || 
          (Skill.find(sk_check.skill_id).name == 'Two Handed Blunt' && sk_check.bought) || 
          (Skill.find(sk_check.skill_id).name == 'Two Handed Sword' && sk_check.bought) || 
          (Skill.find(sk_check.skill_id).name == 'Two Handed Master' && sk_check.bought) || 
          (Skill.find(sk_check.skill_id).name == 'Weapon Master' && sk_check.bought)
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Two Weapons'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Florentine' && sk_check.bought
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Assassinate' || Skill.find(self.skill_id).name == 'Dodge'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Backstab' && (sk_check.amount - (self.amount * 2)) >= 2
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Disarm'
      skills_arr.each do |sk_check|
        if (Skill.find(sk_check.skill_id).name == 'Backstab' && (sk_check.amount - (self.amount * 1)) >= 1) || (Skill.find(sk_check.skill_id).name == 'Weapon Proficiency' && (sk_check.amount - (self.amount * 1)) >= 1)
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Evade'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Backstab' && (sk_check.amount - (self.amount * 1)) >= 1
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Eviscerate'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Weapon Proficiency' && (sk_check.amount - (self.amount * 4)) >= 4
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Parry' || Skill.find(self.skill_id).name == 'Slay'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Weapon Proficiency' && (sk_check.amount - (self.amount * 2)) >= 2
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Riposte'
      skills_arr.each do |sk_check|
        if (Skill.find(sk_check.skill_id).name == 'Backstab' && (sk_check.amount - (self.amount * 4)) >= 4) || (Skill.find(sk_check.skill_id).name == 'Weapon Proficiency' && (sk_check.amount - (self.amount * 4)) >= 4)
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Shatter' || Skill.find(self.skill_id).name == 'Stun Limb'
      skills_arr.each do |sk_check|
        if (Skill.find(sk_check.skill_id).name == 'Backstab' && (sk_check.amount - (self.amount * 3)) >= 3) || (Skill.find(sk_check.skill_id).name == 'Weapon Proficiency' && (sk_check.amount - (self.amount * 3)) >= 3)
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Terminate'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Backstab' && (sk_check.amount - (self.amount * 4)) >= 4
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Backstab'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Back Attack' && sk_check.amount == 4
          sk_check.amount = 0
          sk_check.save
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Weapon Proficiency'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Critical Attack' && sk_check.amount == 4
          sk_check.amount = 0
          sk_check.save
          return true
        end
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Break Command'
      if Race.find(Character.find(self.character_id).race_id).name == 'Biata' || Race.find(Character.find(self.character_id).race_id).name == 'Mystic Wood Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Stone Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Claws'
      if Race.find(Character.find(self.character_id).race_id).name == 'Sarr' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Gypsy Curse'
      if Race.find(Character.find(self.character_id).race_id).name == 'Gypsy' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Racial Assassinate'
      if Race.find(Character.find(self.character_id).race_id).name == 'Sarr' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Racial Dodge'
      if Race.find(Character.find(self.character_id).race_id).name == 'Hobling' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Racial Proficiency'
      if Race.find(Character.find(self.character_id).race_id).name == 'High Ogre' || Race.find(Character.find(self.character_id).race_id).name == 'High Orc' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Racial Slay'
      if Race.find(Character.find(self.character_id).race_id).name == 'High Orc' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Resist Binding'
      if Race.find(Character.find(self.character_id).race_id).name == 'Dryad' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Resist Command'
      if Race.find(Character.find(self.character_id).race_id).name == 'Biata' || Race.find(Character.find(self.character_id).race_id).name == 'Dark Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Mystic Wood Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Stone Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Resist Element'
      if Race.find(Character.find(self.character_id).race_id).name == 'Barbarian' || Race.find(Character.find(self.character_id).race_id).name == 'Dwarf' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Resist Fear'
      if Race.find(Character.find(self.character_id).race_id).name == 'Barbarian' || Race.find(Character.find(self.character_id).race_id).name == 'High Orc' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Resist Magic'
      if Race.find(Character.find(self.character_id).race_id).name == 'Dark Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Resist Necromancy'
      if Race.find(Character.find(self.character_id).race_id).name == 'High Ogre' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif Skill.find(self.skill_id).name == 'Resist Poison'
      if Race.find(Character.find(self.character_id).race_id).name == 'Dwarf' || Race.find(Character.find(self.character_id).race_id).name == 'Hobling' || Race.find(Character.find(self.character_id).race_id).name == 'Sarr' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    else
      return true
    end
  end

end
