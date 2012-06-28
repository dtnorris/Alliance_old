require 'spec_helper'

describe XpTrack do
  let(:new_character) do
    new_character = Character.create 
    new_character.build_points = 15
    new_character.experience_points = 0
    new_character.char_class_id = 1
    new_character
  end

  it "should add rows when character adds xp" do
    XpTrack.all.count.should == 0
    new_character.add_xp(2, "Test Weekend")
    new_character.add_xp(2, "Test Weekend")
    XpTrack.all.count.should == 2
  end
end
