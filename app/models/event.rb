class Event < ActiveRecord::Base
  attr_accessible :chapter_id, :date, :name, :event_type_id, :applied

  has_many :patron_xp

  validates_presence_of :name
  validates_presence_of :chapter_id
  validates_presence_of :date
  validates_presence_of :event_type_id

  def event_reason(event_type)
    event_type.name + ' for ' + Chapter.find(self.chapter_id).name + ' on ' + self.date.to_s
  end

  def apply_blanket
    if applied != true
      self.applied = true
      PatronXp.find_all_by_event_id(self.id).each do |px|
        event_type = EventType.find(event_type_id)
        reason = self.event_reason(event_type)
        Character.find(px.character_id).add_xp(event_type.value, reason) unless px.applied == true
        px.applied = true
        px.save
      end
      self.save
    end
  end

end
