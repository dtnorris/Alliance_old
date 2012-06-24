class Character < ActiveRecord::Base
  attr_accessible :build_points, :experience_points, :name, :race_id, :new_skill, :char_class_id
  belongs_to :race
  belongs_to :char_class
  has_many :character_skill

  before_save :update_xp

  def update_xp
    xp_per_bp = 3
    tmp_bp = 15
    tmp_xp = experience_points
    tmp_lvl = 1

    # Algorithm to calculate build based off of XP
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
    self.build_points = tmp_bp
  end
end
