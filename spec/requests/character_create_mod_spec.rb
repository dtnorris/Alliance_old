require "spec_helper"

describe "character creation and modification" do
  
  before :each do
    visit "/"
    fill_in "user_email", with: "dreamingfurther@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"

    visit "/chapters"
    click_link "New Character"
    fill_in "Character Name:", with: "Bob"
    select("Human", :from => "Race:")
    select("Fighter", :from => "Character Class:")
    click_button "Create Character"
    #save_and_open_page
  end

  it "should have calculated body points on creation" do
    page.should have_content("Body Points: 6")
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
    select("Read And Write", :from => "Add Skill:")
    click_button "add_skills"
    page.should have_content("Read And Write:")
    select("Read And Write", :from => "Add Skill:")
    click_button "add_skills"
    page.should have_content("Read And Write:")
  end

  it "should be able to delete a skill" do
    click_link "Edit"
    select("Read And Write", :from => "Add Skill:")
    click_button "add_skills"
    page.should have_content("Read And Write:")
    click_link "X"
    #save_and_open_page
    #click_button "OK"
    page.should_not have_content("Read And Write:")
  end

  it "should properly re-calculate spent build" do
    click_link "Edit"
    select("Read And Write", :from => "Add Skill:")
    click_button "add_skills"
    select("Read And Write", :from => "Purchase Skill:")
    click_button "add_skills"
    click_link "View"
    page.should have_content("Unspent Build: 9")
    page.should have_content("Spent Build: 6")
    page.should have_content("Total Build: 15")
  end

  it "should calculate build exactly" do
    click_link "Edit"
    select("Read And Write", :from => "Add Skill:")
    click_button "add_skills"
    select("Herbal Lore", :from => "Add Skill:")
    click_button "add_skills"
    select("Blacksmith", :from => "Add Skill:")
    click_button "add_skills"
    select("Read And Write", :from => "Purchase Skill:")
    click_button "add_skills"
    select("Herbal Lore", :from => "Purchase Skill:")
    click_button "add_skills"
    select("Blacksmith", :from => "Purchase Skill:")
    click_button "add_skills"
    page.should_not have_content("Please review the problems below:")

    select("Blacksmith", :from => "Purchase Skill:")
    click_button "add_skills"
    page.should have_content("You do not have the necessary build for this update")
  end

  it "should be able to add xp on the xp tracking page" do
    visit "/chapters"
    click_link "Edit"
    click_link "XP Track"
    click_link "One Day"
    click_link "Weekend"
    click_link "Long Weekend"
    click_link "Chapters"
    page.should have_content("Bob Human Fighter 38 139")
  end

  it "allows a user to view character XP tracking" do
    visit "/chapters"
    click_link "Edit"
    click_link "XP Track"
    click_link "One Day"
    click_link "Mod Day"
    click_link "Weekend"
    click_link "Long Weekend"

    visit "/characters"
    click_link "View"
    click_link "XP Track"
    page.should have_content("Experience Point Tracking for: Bob")
    page.should have_content("id: Start Build: Final Build: Build Gained: Start XP: Final XP: Reason Added:")
  end

end