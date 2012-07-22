class Member < ActiveRecord::Base
  attr_accessible :chapter_id, :goblin_stamps, :user_id

  validates_presence_of :chapter_id
  validates_presence_of :user_id

  def self.data_import cid, uid, goblins
    Member.create(chapter_id: cid, user_id: uid, goblin_stamps: goblins)
  end
end
