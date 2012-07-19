class PatronXp < ActiveRecord::Base
  attr_accessible :applied, :character_id, :event_id, :user_id

  belongs_to :character
  belongs_to :event
  belongs_to :user

  has_one :xp_track
end
