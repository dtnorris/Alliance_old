class Character < ActiveRecord::Base
  attr_accessible :build_points, :experience_points, :name, :race_id, :new_skill, :char_class_id
  belongs_to :race
  belongs_to :char_class
  has_many :character_skill

end
