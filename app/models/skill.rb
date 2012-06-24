class Skill < ActiveRecord::Base
  attr_accessible :adept_cost, :artisan_cost, :fighter_cost, :name, :rogue_cost, :scholar_cost, :scout_cost, :templar_cost, :skill_type
end
