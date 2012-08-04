require "spec_helper"

describe "character skill manipulation" do
  
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"

    visit "/chapters/1"
    click_link "chapter_players"
    click_link "New Character"
    fill_in "Character Name:", with: "Fred"
    select("Human", :from => "Race:")
    select("Fighter", :from => "Character Class:")
    click_button "Create Character"
    #debugger
    click_link "Edit"
  end

  it "should be able to add backstabs/profs with more than 4 prereqs" do
    char = Character.find_by_name("Fred")
    char.experience_points = 10000
    char.save
    #debugger
    select("One Handed Edged", :from => "Add Skill:")
    click_button "add_skills"
    select("Critical Attack", :from => "Add Skill:")
    click_button "add_skills"
    select("Weapon Proficiency", :from => "Add Skill:")
    click_button "add_skills"
    select("One Handed Edged", :from => "Purchase Skill:")
    click_button "add_skills"
    for i in 0..5
      select("Critical Attack", :from => 'Purchase Skill:')
      click_button 'add_skills'
    end
    select('Weapon Proficiency', :from => 'Purchase Skill:')
    click_button 'add_skills'
    #save_and_open_page
    page.should have_content('Weapon Proficiency: 1')
    page.should have_content('Critical Attack: 2')
  end
end