require "spec_helper"

describe "character creation and modification" do
  
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"

    visit "/chapters/2"
    click_link "chapter_players"
    click_link "New Character"
    fill_in "Character Name:", with: "Bob"
    select("Human", :from => "Race:")
    select("Fighter", :from => "Character Class:")
    click_button "Create Character"
  end

  # it "should see build costs by each class option" do
  #   pending
  # end

  it 'should have multiple edit buttons and pdf buttons' do 
    click_link('edit_button')
    page.should have_content('Choose Skill: VariousAlchemyBlacksmithCraftsmanCreate PotionCreate ScrollCreate TrapFirst AidHealing ArtsHerbal LoreLegerdemainMerchantRead And WriteRead MagicTeacherWear Extra Armor')
  end

  it 'should have the correct links after creating new character' do
    click_link 'XP Track'
    page.should have_content('Start Build: Final Build: Build Gained: Start XP: Final XP: Reason Added:')
    click_link 'Back'
    page.should have_content('Name Race Class Level Player')
    page.should have_content('Bob Human Fighter 1 Alliance Admin')
  end

  it "should be able to edit character race and class" do
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
    page.should have_content("Deaths: 0")
    page.should have_content("Regen/CSS Deaths: 0")
    page.should have_content("Deaths Bought Back: 0")
  end

  it "should be able to view xp_track" do
    click_link "XP Track"
    page.should have_content("Start Build: Final Build: Build Gained: Start XP: Final XP: Reason Added:")
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
    page.should have_content("Deaths: 0")
    page.should have_content("Regen/CSS Deaths: 0")
    page.should have_content("Deaths Bought Back: 0")
  end

  it "should be about to go to the view page after creation" do
    click_link "View"
    page.should have_content("PDF Character Card")
  end

  it "should properly re-calculate spent build" do
    click_link "Edit"
    select "Read And Write", from: 'Choose Skill: Various'
    click_button "add_skills"
    within(:xpath, "//tr[.//*[contains(text(), 'Read And Write')]]") do
      click_link 'Add'
    end
    click_link "View"
    page.should have_content("Unspent Build: 9")
    page.should have_content("Spent Build: 6")
    page.should have_content("Total Build: 15")
  end

  it "should calculate build exactly" do
    click_link "Edit"
    select "Read And Write", from: 'Choose Skill: Various'
    click_button "add_skills"
    select "Herbal Lore", from: 'Choose Skill: Various'
    click_button "add_skills"
    select "Blacksmith", from: 'Choose Skill: Various'
    click_button "add_skills"
    within(:xpath, "//tr[.//*[contains(text(), 'Read And Write')]]") do
      click_link 'Add'
    end
    within(:xpath, "//tr[.//*[contains(text(), 'Herbal Lore')]]") do
      click_link 'Add'
    end
    within(:xpath, "//tr[.//*[contains(text(), 'Blacksmith')]]") do
      click_link 'Add'
    end
    page.should_not have_content("Please review the problems below:")

    within(:xpath, "//tr[.//*[contains(text(), 'Blacksmith')]]") do
      click_link 'Add'
    end
    page.should have_content("You do not have the necessary build for this update")
  end

end