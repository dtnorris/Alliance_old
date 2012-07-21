class PatronXp < ActiveRecord::Base
  attr_accessible :applied, :character_id, :event_id, :pc

  belongs_to :character
  belongs_to :event

  has_one :xp_track

  validates_presence_of :character_id
  validates_presence_of :event_id

  def apply_event
    event = Event.find(self.event_id)
    event_type = EventType.find(event.event_type_id)
    reason = event.event_reason(event_type)
    Character.find(self.character_id).add_xp(event_type.value, reason)
    self.applied = true
    self.save
  end
end
