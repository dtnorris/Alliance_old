require 'spec_helper'

describe User do
  describe "basic user functionality" do
    let!(:chapter) { FactoryGirl.create(:chapter) }
    let!(:user) { FactoryGirl.create(:user) }
    let!(:mem1) { FactoryGirl.create(:member) }
    let!(:char) { FactoryGirl.create(:character) }
    let!(:char1) { FactoryGirl.create(:character) }
    let!(:char2) { FactoryGirl.create(:character) }
    let!(:attendee) { FactoryGirl.create(:attendee) }

    it "should be able to return all users of given memberships" do
      User.all_for_given_members([mem1]).count.should == 1
    end

    it "should be able to return all_characters_for_user" do
      user.all_characters_for_user.count.should == 3
    end

    it "should be able to return full name" do
      user.name.should == "hello world"
    end

    it "should be able to return all_attendees" do
      user.all_attendees.count.should == 1
    end
  end

  describe "user import" do
    before :each do
      Chapter.data_import({ name: 'Southern Minnesota', owner: 'David Glaiser', email: 'dg@test.com', location: 'soMN' })
    end

    it "should import users from csv" do
      user_data = DataImport.user_import("#{Rails.root}/data/test_members.csv")
      User.data_import(user_data, 'soMN')

      User.all.count.should == 4
    end
  end
end
