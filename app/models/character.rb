class Character < ActiveRecord::Base
  attr_accessible :build_points, :experience_points, :name, :race_id, :new_skill
  belongs_to :race
  has_many :character_skill

end
