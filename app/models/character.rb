class Character < ActiveRecord::Base
  attr_accessible :build_points, :experience_points, :name, :race_id, :new_skill, :char_class_id, :spent_build
  belongs_to :race
  belongs_to :char_class
  has_many :character_skill

  before_save :update_xp
  before_save :calculate_spent_build

  def add_xp(multiplier)
    self.experience_points += build_points * multiplier
    self.save
  end

  def calculate_spent_build
    if experience_points
      skills_array = CharacterSkill.find_all_by_character_id(self.id)
      if skills_array
        tmp_spent_build = 0
        skills_array.each do |skill|
          sk = Skill.find(skill.skill_id)
          class_name = self.char_class.name.downcase
          if sk.skill_type == 'int'
            tmp_spent_build += sk[class_name] * skill.amount
          else
            tmp_spent_build += sk[class_name]
          end
        end
        self.spent_build = tmp_spent_build
      end
    end
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
