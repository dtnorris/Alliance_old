class Event < ActiveRecord::Base
  attr_accessible :chapter_id, :date, :name, :event_type_id, :applied

  belongs_to :chapter
  belongs_to :event_type

  has_many :attendees

  validates_presence_of :name
  validates_presence_of :chapter_id
  validates_presence_of :date
  validates_presence_of :event_type_id

  UNRANSACKABLE_ATTRIBUTES = ['id','chapter_id','event_type_id','date','applied','created_at','updated_at']

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  def nice_date
    Date::MONTHNAMES[date.month] + ', ' + date.year.to_s
  end

  def event_reason(event_type)
    "#{event_type.name} for #{Chapter.find(self.chapter_id).name} on #{Date::MONTHNAMES[date.month]}, #{date.day.to_s}, #{date.year.to_s}"
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
