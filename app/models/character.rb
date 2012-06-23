class Character < ActiveRecord::Base
  attr_accessible :name, :build_points, :experience_points #, :character_id, :home_chapter
end
