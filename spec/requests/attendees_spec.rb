require 'spec_helper'

describe "Attendees" do
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"
    visit "/chapters"
  end

  it "should be able to create a new attendee from the chapter" do
    click_link "Home"
    click_link "Chapter Events"
    click_link "View Attendees"
    select("Alliance Admin", :from => "Select a Member:")
    select("Bob", :from => "Character")
    select("PC", :from => "PC or NPC")
    click_button "Add Attendee"
    page.should have_content("Alliance Admin PC Bob 1 false Apply Event")
  end

  it "should be able to show a list of events attended" do
    click_link "Home"
    click_link "Chapter Events"
    click_link "Apply Event"
    click_link "Home - admin@test.com"
    click_link "Events Attended"
    page.should have_content("Bob T_Chapter_1 2012-07-20 Faire Day true")
  end

  it "should be able to add an attendee form the user homepage" do
    click_link "Home - admin@test.com"
    click_link "View Events"
    click_link "Attend"
    select("Alliance Admin", :from => "Select Yourself:")
    select("Bob", :from => "Character")
    select("PC", :from => "PC or NPC")
    click_button "Attend Event"
    page.should have_content("Bob T_Chapter_1 2012-07-20 Faire Day false")
  end
end
