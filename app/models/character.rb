class Character < ActiveRecord::Base
  attr_accessible :build_points, :experience_points, :name
end
