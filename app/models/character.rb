class Character < ActiveRecord::Base
  attr_accessible :build_points, :experience_points, :name, :race_id
  belongs_to :race
end
