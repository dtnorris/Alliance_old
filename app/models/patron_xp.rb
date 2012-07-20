class PatronXp < ActiveRecord::Base
  attr_accessible :applied, :character_id, :event_id, :pc

  belongs_to :character
  belongs_to :event

  has_one :xp_track

  validates_presence_of :character_id
  validates_presence_of :event_id
end
