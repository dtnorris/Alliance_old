class Event < ActiveRecord::Base
  attr_accessible :chapter_id, :date, :name, :event_type_id, :applied

  has_many :attendee

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
      Attendee.find_all_by_event_id(self.id).each do |px|
        px.apply_event
      end
      self.save
    end
  end

end
