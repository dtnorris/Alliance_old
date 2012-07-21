require 'spec_helper'

describe PatronXp do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:char) { FactoryGirl.create(:character) }
  let!(:patron) { FactoryGirl.create(:patron_xp) }

  it "should be able to call user_id" do
    patron.user_id.should == 2
  end
end
