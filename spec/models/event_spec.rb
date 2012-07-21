require 'spec_helper'

describe Event do
  let!(:new_char) { FactoryGirl.create(:character) }
  let!(:event) { FactoryGirl.create(:event) }
  let!(:new_patron) { FactoryGirl.create(:patron_xp) }
  let!(:new_patron2) { FactoryGirl.create(:patron_xp) }
  let!(:event_type) { FactoryGirl.create(:event_type) }

  it "should be able to return an event reason" do
    event.event_reason(event_type).should == "MyString for Caldaria on 2012-07-18"
  end

  it "should be able to apply an event_blanket that applies patrons" do
    event.apply_blanket
    event.applied.should == true
    PatronXp.find_all_by_event_id(event.id).each do |px|
      px.applied.should == true
    end
  end

end
