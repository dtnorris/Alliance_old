require 'spec_helper'

describe User do
  let!(:chapter) { FactoryGirl.create(:chapter) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:mem1) { FactoryGirl.create(:member) }
  let!(:char) { FactoryGirl.create(:character) }
  let!(:char1) { FactoryGirl.create(:character) }
  let!(:char2) { FactoryGirl.create(:character) }
  let!(:patron) { FactoryGirl.create(:patron_xp) }

  it "should be able to return all users of given memberships" do
    User.all_for_given_members([mem1]).count.should == 1
  end

  it "should be able to return all_characters_for_user" do
    user.all_characters_for_user.count.should == 3
  end

  it "should be able to return full name" do
    user.name.should == "hello world"
  end

  it "should be able to return all_patron_xps" do
    user.all_patron_xps.count.should == 1
  end
end
