class PatronXp < ActiveRecord::Base
  attr_accessible :applied, :character_id, :event_id, :pc

  belongs_to :character
  belongs_to :event

  has_one :xp_track

  validates_presence_of :character_id
  validates_presence_of :event_id

  def user_id
    User.find(Character.find(self.character_id).user_id).id if self.character_id
  end

  def apply_event
    if applied == false
      event = Event.find(self.event_id)
      event_type = EventType.find(event.event_type_id)
      reason = event.event_reason(event_type)
      xp = Character.find(self.character_id).add_xp(event_type.value, reason)
      xp.patron_xp_id = self.id
      xp.save
      self.applied = true
      self.save
    else
      false
    end
  end
end
