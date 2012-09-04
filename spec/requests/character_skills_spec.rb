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
    click_link "Edit"
  end

  it 'should not error when attempting to add no new 0 build skill' do 
    click_button 'Add Skill'
    page.should have_content 'No skill selected.'
  end

  it 'should not be able to purchase a skill without the pre-reqs' do 
    select 'Weapon Proficiency', from: 'Choose Skill: Martial Skill'
    click_button 'add_skills'
    click_link 'Add'
    page.should have_content 'Pre-requisites are not met to purchase this skill'
    page.should have_content 'Weapon Proficiency: 0'
  end

  it 'should be able to purchase skill' do
    click_link "Edit"
    select "Read And Write", from: 'Choose Skill: Spells'
    click_button "add_skills"
    page.should have_content("Read And Write:")
    click_link "Add"
    page.should have_content("Read And Write: 1")
  end

  it "should be able to add new skill" do
    click_link "Edit"
    select "Read And Write", from: 'Choose Skill: Spells'
    click_button "add_skills"
    page.should have_content("Read And Write: 0")
  end

  it "should be able to delete a 0 skill" do
    click_link "Edit"
    select "Read And Write", from: 'Choose Skill: Spells'
    click_button "add_skills"
    page.should have_content("Read And Write:")
    click_link "X"
    page.should_not have_content("Read And Write:")
  end

  it 'should be able to delete a purchased skill without removing the skill' do 
    click_link 'Edit'
    select 'Read And Write', from: 'Choose Skill: Spells'
    click_button 'add_skills'
    click_link 'Add'
    click_link 'X'
    page.should have_content 'Skill Removed'
    page.should have_content 'Read And Write: 0'
  end

  it 'should only remove a skill entirely if it is not purchased' do
    click_link 'Edit'
    select 'Blacksmith', from: 'Choose Skill: Various'
    click_button 'add_skills'
    click_link 'Add'
    click_link 'Add'
    click_link 'X'
    page.should have_content('Blacksmith: 1')
  end

  it "should be able to add backstabs/profs with more than 4 prereqs" do
    char = Character.find_by_name("Fred")
    char.experience_points = 10000
    char.save
    select "One Handed Edged", from: 'Choose Skill: Weapon'
    click_button "add_skills"
    select "Critical Attack", from: 'Choose Skill: Martial Skill'
    click_button "add_skills"
    select "Weapon Proficiency", from: 'Choose Skill: Martial Skill'
    click_button "add_skills"
    within(:xpath, "//tr[.//*[contains(text(), 'One Handed Edged')]]") do
      click_link 'Add'
    end
    for i in 0..5
      within(:xpath, "//tr[.//*[contains(text(), 'Critical Attack')]]") do
        click_link 'Add'
      end
    end
    within(:xpath, "//tr[.//*[contains(text(), 'Weapon Proficiency')]]") do
      click_link 'Add'
    end
    #save_and_open_page
    page.should have_content('Weapon Proficiency: 1')
    page.should have_content('Critical Attack: 2')
  end

  it 'should be able to add backstabs/profs with no crit attacks' do 
    char = Character.find_by_name("Fred")
    char.experience_points = 10000
    char.save
    select 'One Handed Edged', from: 'Choose Skill: Weapon'
    click_button 'add_skills'
    select 'Critical Attack', from: 'Choose Skill: Martial Skill'
    click_button 'add_skills'
    select 'Weapon Proficiency', from: 'Choose Skill: Martial Skill'
    click_button 'add_skills'
    within(:xpath, "//tr[.//*[contains(text(), 'One Handed Edged')]]") do
      click_link 'Add'
    end
    within(:xpath, "//tr[.//*[contains(text(), 'Weapon Proficiency')]]") do
      click_link 'Add'
    end
    page.should have_content 'Character was successfully updated'
    page.should have_content 'Weapon Proficiency: 1'
  end
end