require 'spec_helper'

describe Attendee do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:char) { FactoryGirl.create(:character) }
  let!(:attendee) { FactoryGirl.create(:attendee) }

  it "should be able to call user_id" do
    attendee.user_id.should == 2
  end
end
