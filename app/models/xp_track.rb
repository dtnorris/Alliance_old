class XpTrack < ActiveRecord::Base
  attr_accessible :character_id, :end_xp, :reason, :start_xp, :start_build, :end_build
end
