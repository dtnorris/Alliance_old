class EventType < ActiveRecord::Base
  attr_accessible :name, :value

  has_many :events
end
