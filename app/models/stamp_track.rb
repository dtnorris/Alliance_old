class StampTrack < ActiveRecord::Base
  attr_accessible :user_id, :chapter_id, :start_stamps, :end_stamps, :reason, :dragon_stamps

  attr_accessor :amount_to_change

  belongs_to :chapter
  belongs_to :user

  def self.data_import cid, uid, amount
    StampTrack.create(user_id: uid, chapter_id: cid, end_stamps: amount, start_stamps: 0, reason: 'Data Import', dragon_stamps: false)
  end
end
