require "spec_helper"

describe "character creation and modification" do
  before :each do
    visit "/characters"
    click_link "New Character"
    fill_in "Character Name:", with: "Bob"
    select("Human", :from => "Race:")
    select("Fighter", :from => "Character Class:")
    click_button "Create Character"
  end

  it "should be able to create a new character" do
    page.should have_content("Name: Bob")
    page.should have_content("Race: Human")
    page.should have_content("Class: Fighter")
    page.should have_content("Level: 1")
    page.should have_content("XP Points: 0")
    page.should have_content("Unspent Build: 15")
    page.should have_content("Spent Build: 0")
    page.should have_content("Total Build: 15")
  end

  it "should be able to edit character skills" do
    click_link "Edit"
    fill_in "Character Name:", with: "Eldarion"
    select("Dark Elf", :from => "Race:")
    select("Adept", :from => "Character Class:")
    click_button "Update Character"
    click_link "View"
    page.should have_content("Name: Eldarion")
    page.should have_content("Race: Dark Elf")
    page.should have_content("Class: Adept")
    page.should have_content("Level: 1")
  end

  it "should be about to go to the view page after creation" do
    click_link "Back"
    page.should have_content("Bob Human Fighter 1")
  end

  it "should be able to add new skill" do
    click_link "Edit"
    select("Read And Write", :from => "Add New Character Skill:")
    click_button "Update Character"
    page.should have_content("Read And Write:")
    select("Read And Write", :from => "Add New Character Skill:")
    click_button "Update Character"
    page.should have_content("Read And Write:")
  end

end