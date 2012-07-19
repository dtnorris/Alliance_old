class Event < ActiveRecord::Base
  attr_accessible :chapter_id, :date, :name, :xp_value

  has_many :patron_xp

  validates_presence_of :chapter_id
  validates_presence_of :date
  validates_presence_of :xp_value
end
