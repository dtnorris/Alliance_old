class StampTrack < ActiveRecord::Base
  attr_accessible :user_id, :chapter_id, :start_stamps, :end_stamps, :reason, :dragon

  attr_accessor :amount_to_change
end
