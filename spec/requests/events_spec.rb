require 'spec_helper'

describe "events navigation" do
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"
    visit "/chapters"
  end

  it 'back buttons goes back to chapter show page from blanket event' do 
    click_link 'T_Chapter_1'
    click_link 'New'
    click_button 'Create Event'
    click_link 'View Attendees'
    click_link 'Back'
    page.should have_content 'Monthly Blankets'
  end

  it "should be able to create an event" do
    click_link 'T_Chapter_1'
    click_link "New Event"

    fill_in "Name", with: "test event"
    click_button "Create Event"
    page.should have_content("Event was successfully created.")
    page.should have_content 'test event'
    page.should have_content 'Module Day'
  end

  it "should be able to view/add attendees" do
    click_link 'T_Chapter_1'
    click_link "New Event"
    fill_in "Name", with: "test event"
    click_button "Create Event"
    click_link 'test event'

    select("Alliance Admin", :from => "Select a Member:")
    select("Bob", :from => "Character")
    click_button "Add Attendee"
    page.should have_content("Attendee successfully added to the event")
    page.should have_content("Alliance Admin NPC Bob 1 false")
    
    select("Alliance Admin", :from => "Select a Member:")
    select("Bob", :from => "Character")
    select("PC", :from => 'PC or NPC')
    click_button "Add Attendee"
    page.should have_content("Attendee successfully added to the event")
    page.should have_content("Alliance Admin PC Bob 1 false")   
  end

  it "should be able to apply a single blanket" do
    click_link 'T_Chapter_1'
    click_link "New Event"
    fill_in "Name", with: "test event"
    click_button "Create Event"
    click_link 'test event'
    select("Alliance Admin", :from => "Select a Member:")
    select("Bob", :from => "Character")
    click_button "Add Attendee"

    click_link "Apply Event"
    page.should have_content("Single Blanket successfully applied")
    page.should have_content("Bob 1 true")
  end

  it "should be able to apply blanket to entire event" do
    click_link 'T_Chapter_1'
    click_link "New Event"
    fill_in "Name", with: "test event"
    click_button "Create Event"
    click_link 'test event'
    select("Alliance Admin", :from => "Select a Member:")
    select("Bob", :from => "Character")
    click_button "Add Attendee"
    click_link "Back"

    click_link "Apply Event"
    page.should have_content("Event was successfully applied")
    click_link 'test event'
    page.should have_content("Bob 1 true")
    click_link 'Administrate'
    click_link 'Characters'
    click_link 'Bob'
    click_link 'XP Track'
    time = '15 17 2 0 7 Module Day for T_Chapter_1 on '
    page.should have_content time
  end
end
