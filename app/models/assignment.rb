class Assignment < ActiveRecord::Base
  attr_accessible :chapter_id, :role_id, :user_id

  belongs_to :user
  belongs_to :role
  belongs_to :chapter

  validates_presence_of :user_id
  validates_presence_of :role_id

  def self.data_import uid
    Assignment.create(user_id: uid, role_id: 1)
  end
end
