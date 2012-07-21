class Character < ActiveRecord::Base
  attr_accessible :build_points, :experience_points, :name, :race_id, :new_skill, :char_class_id, :spent_build, :buy_skill, :body_points, :user_id, :home_chapter
  belongs_to :race
  belongs_to :char_class
  has_many :character_skill
  has_many :xp_track
  has_many :patron_xp

  after_create :purchase_racial_skills

  before_save :update_xp_and_build
  before_save :update_body
  after_save :update_spent_build

  validates_presence_of :user_id
  validates_presence_of :name
  validates_presence_of :race_id
  validates_presence_of :char_class_id
  validates_presence_of :home_chapter
  validate :legal_spent_build

  def self.memberships_of_user(id)
    memberships = Member.find_all_by_user_id(id)
    chapters = []
    memberships.each do |ch|
      chapters << Chapter.find(ch.chapter_id)
    end
    chapters
  end

  def add_xp(multiplier, reason)
    xp_track = XpTrack.create
    xp_track.character_id = id
    xp_track.start_xp = experience_points
    xp_track.start_build = build_points
    xp_track.reason = reason

    self.experience_points += build_points * multiplier
    xp_track.end_xp = experience_points
    self.save
    
    xp_track.end_build = build_points
    xp_track.save
  end

  def update_body
    self.body_points = 0
    self.body_points += 6 + Race.find(self.race_id).body_mod
    self.body_points += (self.build_points - 15) / CharClass.find(self.char_class_id).build_per_body
  end

  def legal_spent_build
    if build_points >= self.calculate_spent_build
      return true
    else
      errors.add(:char_class_id, "You do not have the necessary build for this update")
    end
  end

  def update_spent_build
    tmp_build = self.calculate_spent_build
    self.update_column(:spent_build, tmp_build)
  end

  def calculate_spent_build
    if experience_points
      skills_array = CharacterSkill.find_all_by_character_id(self.id)
      tmp_spent_build = 0
      if skills_array
        skills_array.each do |skill|
          if skill.amount != 0 && skill.bought != false
            sk = Skill.find(skill.skill_id)
            class_name = self.char_class.name.downcase
            if sk.skill_type == 'int'
              tmp_spent_build += sk[class_name] * skill.amount
            else
              tmp_spent_build += sk[class_name]
            end
          end
        end
      end
      tmp_spent_build
    end
  end

  def update_xp_and_build
    xp_per_bp = 3
    tmp_bp = 15
    tmp_xp = experience_points
    tmp_lvl = 1

    # Algorithm to calculate build based off of XP
    if experience_points
      while tmp_xp > 0
        if tmp_xp >= xp_per_bp
          tmp_bp += 1
        end
        tmp_xp -= xp_per_bp
        if ((tmp_bp - 15) / 10) == tmp_lvl
          tmp_lvl += 1
          xp_per_bp += tmp_lvl + 2
        end
      end
    end
    self.build_points = tmp_bp
  end

  def purchase_racial_skills
    race = Race.find(self.race_id).name
    if race == "Barbarian"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Element').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Fear').id)
    elsif race == "Biata"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Break Command').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Command').id)
    elsif race == "Dark Elf"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Command').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Magic').id)
    elsif race == "Dryad"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Binding').id)
    elsif race == "Dwarf"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Element').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Poison').id)
    elsif race == "Elf"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Command').id)
    elsif race == "Gypsy"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Gypsy Curse').id)
    elsif race == "High Ogre"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Racial Proficiency').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Necromancy').id)
    elsif race == "High Orc"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Racial Proficiency').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Racial Slay').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Fear').id)
    elsif race == "Hobling"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Racial Dodge').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Poison').id)
    elsif race == "Mystic Wood Elf"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Break Command').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Command').id)
    elsif race == "Sarr"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Racial Assassinate').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Poison').id)
    elsif race == "Stone Elf"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Break Command').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Command').id)
    end
  end
  
end
