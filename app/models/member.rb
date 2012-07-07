class Member < ActiveRecord::Base
  attr_accessible :chapter_id, :goblin_stamps, :user_id

  validates_presence_of :chapter_id
  validates_presence_of :user_id
end
