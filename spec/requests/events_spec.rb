require 'spec_helper'

describe "events navigation" do
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"
    visit "/chapters"
  end

  it "should be able to create an event" do
    click_link "Home"
    click_link "New Event"

    fill_in "Name", with: "test event"
    click_button "Create Event"
    page.should have_content("Event was successfully created.")
    page.should have_content("T_Chapter_1 test event Module Day")
  end

  it "should be able to view/add attendees" do
    click_link "Home"
    click_link "New Event"
    fill_in "Name", with: "test event"
    click_button "Create Event"
    click_link "View Attendees"

    select("Alliance Admin", :from => "Select a Member:")
    select("Bob", :from => "Character")
    click_button "Add Attendee"
    page.should have_content("attendee successfully added to the event")
    page.should have_content("Alliance Admin NPC Bob 1 false")
    
    select("Alliance Admin", :from => "Select a Member:")
    select("Bob", :from => "Character")
    select("PC", :from => 'PC or NPC')
    click_button "Add Attendee"
    page.should have_content("attendee successfully added to the event")
    page.should have_content("Alliance Admin PC Bob 1 false")   
  end

  it "should be able to apply a single blanket" do
    click_link "Home"
    click_link "New Event"
    fill_in "Name", with: "test event"
    click_button "Create Event"
    click_link "View Attendees"
    select("Alliance Admin", :from => "Select a Member:")
    select("Bob", :from => "Character")
    click_button "Add Attendee"

    click_link "Apply Event"
    page.should have_content("Single Blanket successfully applied")
    page.should have_content("Bob 1 true")
  end

  it "should be able to apply blanket to entire event" do
    click_link "Home"
    click_link "New Event"
    fill_in "Name", with: "test event"
    click_button "Create Event"
    click_link "View Attendees"
    select("Alliance Admin", :from => "Select a Member:")
    select("Bob", :from => "Character")
    click_button "Add Attendee"
    click_link "Back"

    click_link "Apply Event"
    page.should have_content("Event was successfully updated")
    click_link "View Attendees"
    page.should have_content("Bob 1 true")
  end
end
