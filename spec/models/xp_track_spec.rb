require 'spec_helper'

describe XpTrack do
  let!(:new_char) { FactoryGirl.create(:character) }
  let!(:new_event) { FactoryGirl.create(:event) }
  let!(:new_patron) { FactoryGirl.create(:patron_xp) }
  let!(:xp_track) { FactoryGirl.create(:xp_track)}

  it "should be able to find_all_by_character_id" do
    XpTrack.find_all_by_character_id(new_char.id).count.should == 1
  end

  it "should be able to call character_id" do
    xp_track.character_id.should == 2
  end

  it "should add rows when character adds xp" do
    XpTrack.all.count.should == 1
    new_char.add_xp(2, "Test Weekend")
    new_char.add_xp(2, "Test Weekend")
    XpTrack.all.count.should == 3
  end
end
