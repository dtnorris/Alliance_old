class XpTrack < ActiveRecord::Base
  attr_accessible :patron_xp_id, :end_xp, :reason, :start_xp, :start_build, :end_build

  def self.find_all_by_character_id(character_id)
    patron_xps = PatronXp.find_all_by_character_id(character_id)
    xp_tracks = []
    patron_xps.each do |p|
      xp_tracks << XpTrack.find_by_patron_xp_id(p.id)
    end
    xp_tracks
  end

  def character_id
    Character.find(PatronXp.find(self.patron_xp_id).character_id).id
  end

end
