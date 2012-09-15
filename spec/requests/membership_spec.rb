require "spec_helper"

describe "basic navigation" do
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"

    visit "chapters/new"
    fill_in "Owner", with: "Dave Glaiser"
    fill_in "Email", with: "mnalliance@test.com"
    fill_in "Name", with: "Gaden"
    fill_in "Location", with: "SoMN"
    click_button "Create Chapter"
  end

  it 'can navigate to goblin stamps' do 
    visit '/chapters'
    click_link 'T_Chapter_1'
    click_link 'chapter_players'
    click_link 'Alliance Admin'
    click_link 'Goblins:'
    page.should have_content 'Stamp Tracking for T_Chapter_1'
  end

  it 'should have a show action chapters can get to' do 
    visit '/chapters'
    click_link 'T_Chapter_1'
    click_link 'chapter_players'
    click_link 'Alliance Admin'
    page.should have_content 'Membership details for Alliance Admin'
    page.should have_content 'Name: Alliance Admin'
    page.should have_content 'Goblins: 0'
  end

  it "should be able to add new membership" do
    click_link "admin@test.com"
    click_link "Profile info"
    select("Gaden", :from => "Chapter")
    click_button "Add Chapter Association"
    page.should have_content("Gaden")

    select("Gaden", :from => "Chapter")
    click_button "Add Chapter Association"
    page.should_not have_content("Gaden/\n/\n0/\n/\n/\n/\nGaden/\n/\n0")
  end

end

