class CharClass < ActiveRecord::Base
  attr_accessible :armor_limit, :build_per_body, :name
  has_many :characters
end
