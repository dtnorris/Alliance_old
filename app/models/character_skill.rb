class CharacterSkill < ActiveRecord::Base
  attr_accessible :character_id, :skill_id, :bought, :amount

  attr_accessor :other, :race, :weapon, :specialty, :spells

  belongs_to :character
  belongs_to :skill

  after_save :update_spent_build

  validate :legal_spent_build, :on => :update

  def self.all_spells character, type
    arr = []
    count = 10
    count.times do |c|
      CharacterSkill.all_bought_skills(character).each do |s|
        if s == "#{type} Level #{c}"
          arr << CharacterSkill.find_by_character_id_and_skill_id(character.id, Skill.find_by_name(s).id).amount
        end
      end
    end
    arr
  end

  def self.all_racials character
    arr = []
    CharacterSkill.all_bought_skills(character).each do |s|
      if Skill.find_by_name(s).group == 'race'
        arr << s
      end
    end
    arr
  end

  def self.all_bought_skills(character)
    all_skills = CharacterSkill.find_all_by_character_id(character.id)
    ret = all_skills.map {|r| Skill.find(r.skill_id).name }
  end

  def self.purchase_skill(character_skill)
    skill = character_skill
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
      return false
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

  def legal_spent_build
    if character_id
      char = self.character
      new_sk = 0
      self_saved = CharacterSkill.find_by_character_id_and_skill_id(self.character_id, self.skill_id)
      if (self_saved.bought != self.bought) || (self_saved.amount != self.amount)
        new_sk = self.skill[CharClass.find(char.char_class_id).name.downcase]
      end
      if char.build_points >= (char.calculate_spent_build + new_sk)
        return true
      else
        return false
      end
    end
  end

  def update_spent_build
    if character_id
      char = Character.find(character_id)
      tmp_build = char.calculate_spent_build
      if char
        char.update_column(:spent_build, tmp_build)
      end
    end
  end

  def check_one_pre_req(pre_req, amount=1)
    skills_arr = CharacterSkill.find_all_by_character_id(self.character_id)
    sk_buying_n = Skill.find(self.skill_id).name
    skills_arr.each do |sk_check|
      if (Skill.find(sk_check.skill_id).name == pre_req && sk_check.amount && sk_check.amount >= amount) || (Skill.find(sk_check.skill_id).name == pre_req && sk_check.bought)
        return true
      end
    end
    return false
  end

  def validate_skill_can_be_purchased
    skills_arr = CharacterSkill.find_all_by_character_id(self.character_id)
    sk_buying_n = Skill.find(self.skill_id).name
    return check_one_pre_req('Herbal Lore') if sk_buying_n == 'Alchemy'
    return check_one_pre_req('Earth Level 1') if sk_buying_n == 'Create Potion'
    return check_one_pre_req('Celestial Level 1') if sk_buying_n == 'Create Scroll'
    return check_one_pre_req('Legerdemain') if sk_buying_n == 'Create Trap'
    return check_one_pre_req('Read And Write') if sk_buying_n == 'Herbal Lore'
    return check_one_pre_req('Read And Write') if sk_buying_n == 'Read Magic'
    return check_one_pre_req('Florentine') if sk_buying_n == 'Two Weapons'
    return check_one_pre_req('Backstab', 2) if sk_buying_n == 'Assassinate'
    return check_one_pre_req('Backstab', 2) if sk_buying_n == 'Dodge'
    return check_one_pre_req('Backstab', 1) if sk_buying_n == 'Disarm'
    return check_one_pre_req('Backstab', 1) if sk_buying_n == 'Evade'
    return check_one_pre_req('Weapon Proficiency', 4) if sk_buying_n == 'Eviscerate'
    return check_one_pre_req('Weapon Proficiency', 2) if sk_buying_n == 'Parry'
    return check_one_pre_req('Weapon Proficiency', 2) if sk_buying_n == 'Slay'
    return check_one_pre_req('Backstab', 2) if sk_buying_n == 'Assassinate'
    return check_one_pre_req('Backstab', 4) if sk_buying_n == 'Terminate'
    return check_one_pre_req('Read Magic') if sk_buying_n == 'Celestial Level 1'
    return check_one_pre_req('Celestial Level 1') if sk_buying_n == 'Celestial Level 2'
    return check_one_pre_req('Celestial Level 2') if sk_buying_n == 'Celestial Level 3'
    return check_one_pre_req('Celestial Level 3') if sk_buying_n == 'Celestial Level 4'
    return check_one_pre_req('Celestial Level 4') if sk_buying_n == 'Celestial Level 5'
    return check_one_pre_req('Celestial Level 5') if sk_buying_n == 'Celestial Level 6'
    return check_one_pre_req('Celestial Level 6') if sk_buying_n == 'Celestial Level 7'
    return check_one_pre_req('Celestial Level 7') if sk_buying_n == 'Celestial Level 8'
    return check_one_pre_req('Celestial Level 8') if sk_buying_n == 'Celestial Level 9'
    return check_one_pre_req('Celestial Level 9') if sk_buying_n == 'Formal Celestial'
    return check_one_pre_req('Healing Arts') if sk_buying_n == 'Earth Level 1'
    return check_one_pre_req('Earth Level 1') if sk_buying_n == 'Earth Level 2'
    return check_one_pre_req('Earth Level 2') if sk_buying_n == 'Earth Level 3'
    return check_one_pre_req('Earth Level 3') if sk_buying_n == 'Earth Level 4'
    return check_one_pre_req('Earth Level 4') if sk_buying_n == 'Earth Level 5'
    return check_one_pre_req('Earth Level 5') if sk_buying_n == 'Earth Level 6'
    return check_one_pre_req('Earth Level 6') if sk_buying_n == 'Earth Level 7'
    return check_one_pre_req('Earth Level 7') if sk_buying_n == 'Earth Level 8'
    return check_one_pre_req('Earth Level 8') if sk_buying_n == 'Earth Level 9'
    return check_one_pre_req('Earth Level 9') if sk_buying_n == 'Formal Earth'
    if sk_buying_n == 'Healing Arts'
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
    elsif sk_buying_n == 'Style Master' || sk_buying_n == 'Back Attack' || sk_buying_n == 'Critical Attack'
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
    elsif sk_buying_n == 'Riposte'
      skills_arr.each do |sk_check|
        if (Skill.find(sk_check.skill_id).name == 'Backstab' && (sk_check.amount - (self.amount * 4)) >= 4) || (Skill.find(sk_check.skill_id).name == 'Weapon Proficiency' && (sk_check.amount - (self.amount * 4)) >= 4)
          return true
        end
      end
      return false
    elsif sk_buying_n == 'Shatter' || sk_buying_n == 'Stun Limb'
      skills_arr.each do |sk_check|
        if (Skill.find(sk_check.skill_id).name == 'Backstab' && (sk_check.amount - (self.amount * 3)) >= 3) || (Skill.find(sk_check.skill_id).name == 'Weapon Proficiency' && (sk_check.amount - (self.amount * 3)) >= 3)
          return true
        end
      end
      return false
    elsif sk_buying_n == 'Backstab'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Back Attack' && sk_check.amount >= 4
          sk_check.amount = sk_check.amount - 4
          sk_check.save
          return true
        end
      end
      return false
    elsif sk_buying_n == 'Weapon Proficiency'
      skills_arr.each do |sk_check|
        if Skill.find(sk_check.skill_id).name == 'Critical Attack' && sk_check.amount >= 4
          sk_check.amount = sk_check.amount - 4
          sk_check.save
          return true
        end
      end
      return false
    elsif sk_buying_n == 'Break Command'
      if Race.find(Character.find(self.character_id).race_id).name == 'Biata' || Race.find(Character.find(self.character_id).race_id).name == 'Mystic Wood Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Stone Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Claws'
      if Race.find(Character.find(self.character_id).race_id).name == 'Sarr' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Gypsy Curse'
      if Race.find(Character.find(self.character_id).race_id).name == 'Gypsy' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Racial Assassinate'
      if Race.find(Character.find(self.character_id).race_id).name == 'Sarr' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Racial Dodge'
      if Race.find(Character.find(self.character_id).race_id).name == 'Hobling' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Racial Proficiency'
      if Race.find(Character.find(self.character_id).race_id).name == 'High Ogre' || Race.find(Character.find(self.character_id).race_id).name == 'High Orc' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Racial Slay'
      if Race.find(Character.find(self.character_id).race_id).name == 'High Orc' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Resist Binding'
      if Race.find(Character.find(self.character_id).race_id).name == 'Dryad' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Resist Command'
      if Race.find(Character.find(self.character_id).race_id).name == 'Biata' || Race.find(Character.find(self.character_id).race_id).name == 'Dark Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Mystic Wood Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Stone Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Resist Element'
      if Race.find(Character.find(self.character_id).race_id).name == 'Barbarian' || Race.find(Character.find(self.character_id).race_id).name == 'Dwarf' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Resist Fear'
      if Race.find(Character.find(self.character_id).race_id).name == 'Barbarian' || Race.find(Character.find(self.character_id).race_id).name == 'High Orc' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Resist Magic'
      if Race.find(Character.find(self.character_id).race_id).name == 'Dark Elf' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Resist Necromancy'
      if Race.find(Character.find(self.character_id).race_id).name == 'High Ogre' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    elsif sk_buying_n == 'Resist Poison'
      if Race.find(Character.find(self.character_id).race_id).name == 'Dwarf' || Race.find(Character.find(self.character_id).race_id).name == 'Hobling' || Race.find(Character.find(self.character_id).race_id).name == 'Sarr' || Race.find(Character.find(self.character_id).race_id).name == 'Wylderkin'
        return true
      end
      return false
    else
      return true
    end
  end

end
