class StampTrack < ActiveRecord::Base
  attr_accessible :user_id, :chapter_id, :start_stamps, :end_stamps, :reason, :dragon_stamps

  attr_accessor :amount_to_change

  belongs_to :chapter
  belongs_to :user

  after_create :update_dragon_stamps

  def self.data_import cid, uid, amount
    StampTrack.create(user_id: uid, chapter_id: cid, end_stamps: amount, start_stamps: 0, reason: 'Data Import', dragon_stamps: false)
  end

  def update_dragon_stamps
    dragons = 0
    StampTrack.where(user_id: self.user.id, dragon_stamps: true).each do |st|
      dragons += st.end_stamps - st.start_stamps
    end
    user.dragon_stamps = dragons
    user.save
  end
end
