class Character < ActiveRecord::Base
  attr_accessible :build_points, :experience_points, :name, :race_id, :new_skill, :character_class_id
  belongs_to :race
  belongs_to :character_class
  has_many :character_skill

end
