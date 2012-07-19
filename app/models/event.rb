class Event < ActiveRecord::Base
  attr_accessible :chapter_id, :date, :name, :xp_value

  has_many :patron_xp
end
