class Character < ActiveRecord::Base
  attr_accessible :build_points, :experience_points, :name, :race_id, :new_skill, :char_class_id, :spent_build, :buy_skill, :body_points
  belongs_to :race
  belongs_to :char_class
  has_many :character_skill
  has_many :xp_track

  before_save :calculate_spent_build
  before_save :update_body
  before_save :update_xp

  validates_presence_of :name, :on => :create
  validates_presence_of :race_id, :on => :create
  validates_presence_of :char_class_id, :on => :create

  def add_xp(multiplier, reason)
    xp_track = XpTrack.create
    xp_track.character_id = id
    xp_track.start_xp = experience_points
    xp_track.reason = reason

    self.experience_points += build_points * multiplier
    xp_track.end_xp = experience_points
    xp_track.save
    self.save
  end

  def calculate_spent_build
    if experience_points
      skills_array = CharacterSkill.find_all_by_character_id(self.id)
      if skills_array
        tmp_spent_build = 0
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
        self.spent_build = tmp_spent_build
      end
    end
  end

  def update_body
    self.body_points = 0
    self.body_points += 6 + Race.find(self.race_id).body_mod
    self.body_points += (self.build_points - 15) / CharClass.find(self.char_class_id).build_per_body
  end


  def update_xp
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
end
