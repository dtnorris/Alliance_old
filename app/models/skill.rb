class Skill < ActiveRecord::Base
  attr_accessible :adept, :artisan, :fighter, :name, :rogue, :scholar, :scout, :templar, :skill_type
end
