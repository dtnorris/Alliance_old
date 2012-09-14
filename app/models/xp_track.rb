class XpTrack < ActiveRecord::Base
  attr_accessible :attendee_id, :end_xp, :reason, :start_xp, :start_build, :end_build

  belongs_to :attendee

  def self.find_all_by_character_id(character_id)
    attendees = Attendee.find_all_by_character_id(character_id)
    xp_tracks = []
    attendees.each do |p|
      if track = XpTrack.find_by_attendee_id(p.id)
        xp_tracks << track
      end
    end
    xp_tracks
  end

  def character_id
    Character.find(Attendee.find(self.attendee_id).character_id).id
  end

end
