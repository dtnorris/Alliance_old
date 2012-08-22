class Character < ActiveRecord::Base
  attr_accessible :build_points, :experience_points, :name, :race_id, :char_class_id, :spent_build, :body_points, :user_id, :chapter_id

  belongs_to :race
  belongs_to :char_class
  belongs_to :chapter
  belongs_to :user

  has_many :character_skills
  has_many :skills, :through => :character_skills
  has_many :attendees
  has_many :members, :through => :user
  has_many :deaths

  after_create :purchase_racial_skills

  before_save :update_xp_and_build
  before_save :update_body
  after_save :update_spent_build

  validates_presence_of :user_id
  validates_presence_of :name
  validates_presence_of :race_id
  validates_presence_of :char_class_id

  validate :legal_spent_build

  UNRANSACKABLE_ATTRIBUTES = ['id','user_id','chapter_id','race_id','char_class_id','experience_points','build_points','spent_build','new_skill','buy_skill','body_points','created_at','updated_at']

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  def self.data_import data, chapter
    ch = Chapter.find_by_location(chapter)
    count = 0
    imported_count = 0
    not_home_count = 0

    data.each do |row|
      hash = {}
      us = User.find_by_first_name_and_last_name(row[:FirstN], row[:LastN])
      #TODO refactor this into chapter name parsing method
      old_home = row[:HomeCampaign]
      if old_home == 'Minnesota' or old_home == 'Southern'
        old_home = 'Southern Minnesota'
      end
      new_home = Chapter.find_by_name(old_home)
      if us && new_home
        hash[:user_id] = us.id if us
        hash[:name] = row[:CName]
        #TODO refactor this into race parsing method
        if row[:Race] == "Orc"
          hash[:race_id] = Race.find_by_name('High Orc').id
        else
          hash[:race_id] = Race.find_by_name(row[:Race].gsub('_', ' ')).id
        end
        hash[:char_class_id] = CharClass.find_by_name(row[:Class]).id
        hash[:chapter_id] = new_home.id
        import = true
      else
        import = false
        if !us
          puts "Record: #{count}, cannot find User: #{row[:FirstN]} #{row[:LastN]} for Character: #{row[:CName]}" unless Rails.env = 'test'
        else
          not_home_count += 1
          #puts "Record: #{count}, not home for Character: #{row[:CName]}, of User: #{row[:FirstN]} #{row[:LastN]}"
        end
      end
      if import
        hash[:experience_points] = row[:'Total XP']
        hash[:build_points] = row[:totalBP]
        hash[:spent_build] = 0

        Character.create hash
        imported_count += 1
      end
      count += 1
    end
    puts "#{count}: total records, records imported: #{imported_count}, Characters not home chapter: #{not_home_count}" unless Rails.env = 'test'
  end

  def add_xp(multiplier, reason)
    xp_track = XpTrack.create
    xp_track.start_xp = experience_points
    xp_track.start_build = build_points
    xp_track.reason = reason

    self.experience_points += build_points * multiplier
    xp_track.end_xp = experience_points
    self.save
    
    xp_track.end_build = build_points
    xp_track.save
    xp_track
  end

  def continuous_skills
    skills = CharacterSkill.all_bought_skills(self)
    ret = []
    skills.each do |sn|
      sk = Skill.find_by_name(sn)
      if (sk.group == 'other' and sk.name != 'Teacher') or sk.group == 'weapon' or sk.name == 'Weapon Proficiency' or sk.name == 'Backstab' or sk.name == 'Read And Write' or sk.name == 'Read Magic' or sk.name == 'First Aid' or sk.name == 'Healing Arts' and sk.name != 'Craftsman'
        ret << sn
      end
    end
    ret
  end

  def per_day_skills
    skills = CharacterSkill.all_bought_skills(self)
    ret = []
    skills.each do |sn|
      sk = Skill.find_by_name(sn)
      if (sk.group == 'specialty' or sk.name == 'Teacher') and (sn != 'Weapon Proficiency') and (sn != 'Backstab')
        ret << sn
      end
    end
    ret
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
      tmp_spent_build = self.add_racial_discounts skills_array, tmp_spent_build
      tmp_spent_build = self.add_racial_costs skills_array, tmp_spent_build
    end
  end

  def add_racial_costs skills_array, spent_build
    if self.has_racial_costs
      skills_array.each do |s|
        if (self.race.name == 'Barbarian' || self.race.name == 'High Orc' || self.race.name == 'High Ogre' || self.race.name == 'Wylderkin') and (s.skill.name == 'Read And Write' || s.skill.name == 'Read Magic') and s.bought
          spent_build += s.skill[self.char_class.name.downcase]
        elsif self.race.name == 'Dwarf' and s.skill.name == 'Read Magic' and s.bought
          spent_build += s.skill[self.char_class.name.downcase]
        end
      end
    end
    spent_build
  end

  def add_racial_discounts skills_array, spent_build
    if self.has_racial_discounts
      skills_array.each do |s|
        if (self.race.name == 'Dark Elf' || self.race.name == 'Elf' || self.race.name == 'Stone Elf') and s.skill.name == 'Archery' and s.bought
          spent_build -= (s.skill[self.char_class.name.downcase] / 2)
        elsif self.race.name == 'Dryad' and s.skill.name == 'Herbal Lore' and s.bought
          spent_build -= (s.skill[self.char_class.name.downcase] / 2)
        elsif self.race.name == 'Dwarf' and s.skill.name == 'Blacksmith' and s.amount > 0
          spent_build -= s.amount
        elsif self.race.name == 'Hobling' and s.skill.name == 'Legerdemain' and s.bought
          spent_build -= (s.skill[self.char_class.name.downcase] / 2)
        elsif self.race.name == 'Mystic Wood Elf' and s.skill.name == 'Craftsman' and s.amount > 0
          spent_build -= s.amount
        end
      end
    end
    spent_build
  end

  def has_racial_costs
    (self.race.name == 'Barbarian') or (self.race.name == 'Dwarf') or (self.race.name == 'High Ogre') or (self.race.name == 'High Orc') or (self.race.name == 'Wylderkin')
  end

  def has_racial_discounts
    (self.race.name == 'Dark Elf') or (self.race.name == 'Dryad') or (self.race.name == 'Dwarf') or (self.race.name == 'Elf') or (self.race.name == 'Hobling') or (self.race.name == 'Mystic Wood Elf') or (self.race.name == 'Stone Elf')
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
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Claws').id)
    elsif race == "Stone Elf"
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Break Command').id)
      CharacterSkill.add_skill(self.id, Skill.find_by_name('Resist Command').id)
    end
  end
  
end
