class Attendee < ActiveRecord::Base
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
      reason  = event.event_reason(event_type)
      user    = self.character.user
      chapter = self.event.chapter
      member  = Member.find_by_user_id_and_chapter_id(user.id, chapter.id)
      if event_type.name == 'Goblin Blanket' and member.goblin_stamps >= 30
        StampTrack.create(user_id: user.id, chapter_id: chapter.id, start_stamps: member.goblin_stamps, end_stamps: (member.goblin_stamps - 30), reason: reason, dragon_stamps: false)
        member.goblin_stamps = member.goblin_stamps - 30
        member.save
        apply = true
      end
      if event_type.name != 'Goblin Blanket' or apply == true
        xp = Character.find(self.character_id).add_xp(event_type.value, reason)
        xp.attendee_id = self.id
        xp.save
        self.applied = true
        self.save
      else
        false
      end
    else
      false
    end
  end
end
