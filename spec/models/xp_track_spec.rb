require 'spec_helper'

describe XpTrack do
  let(:new_character) { Character.create(race_id: 11, char_class_id: 1, experience_points: 0, build_points: 15) }

  it "should add rows when character adds xp" do
    XpTrack.all.count.should == 0
    new_character.add_xp(2, "Test Weekend")
    new_character.add_xp(2, "Test Weekend")
    XpTrack.all.count.should == 2
  end
end
