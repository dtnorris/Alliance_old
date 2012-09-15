require "spec_helper"

describe "basic navigation" do
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"
  end

  it 'should follow the edit button from the character page properly' do 
    click_link 'Bob'
    page.should_not have_content 'Edit'
    click_link 'Chapters'
    click_link 'T_Chapter_1'
    click_link 'chapter_characters'
    click_link 'Bob'
    click_link 'View'
    click_link 'edit_button'
    click_link 'Back'
    page.should have_content 'Bob Barbarian Fighter 1 Alliance Admin'
  end

  it 'should go to the user homepage by clicking the brand name' do
    click_link 'Alliance LARP'
    page.should have_content 'Alliance Admin'
    page.should have_content 'Dragon stamps: 0'
  end

  it 'should go to the user homepage by clicking various Home link' do
    click_link 'Home - admin@test.com'
    page.should have_content 'Alliance Admin'
    page.should have_content 'Dragon stamps: 0'
    click_link 'Home'
    page.should have_content 'Alliance Admin'
    page.should have_content 'Dragon stamps: 0'
    click_link 'Alliance LARP'
    page.should have_content 'Alliance Admin'
    page.should have_content 'Dragon stamps: 0'
  end

  it "should allow a chapter to view chapter characters" do
    click_link "Chapters"
    click_link 'T_Chapter_1'
    click_link "chapter_characters"
    page.should have_content("T_Chapter_1")
    page.should have_content("Bob Barbarian Fighter 1 Alliance Admin")
  end

  it "allows a user to view Character tab" do
    visit "/characters"
    page.should have_content("All Alliance Characters")
  end

  it "allows a user to view Players tab" do
    visit "/users"
    page.should have_content("All Alliance Users")
  end

  it "allows a user to view Chapter tab" do
    visit "/chapters"
    page.should have_content("Name Location Owner Email")
    page.should have_content("Alliance Chapters")
  end

  it "allows a user to view User page" do
    visit "/users/1"
    page.should have_content("Alliance Admin")
  end

  it 'should present proper back button on character page' do 
    visit '/users/1'
    click_link 'Bob'
    click_link 'Back'
    page.should have_content('Alliance Admin')
    click_link 'Bob'
    click_link 'View'
    click_link 'Back'
    page.should have_content('Alliance Admin')
    click_link 'Bob'
    click_link 'XP Track'
    click_link 'Back'
    page.should have_content('Alliance Admin')
    click_link 'Bob'
    click_link 'Back'
    page.should have_content('Alliance Admin')
  end

  it 'should present proper back button on character page from chapter' do
    visit '/chapters/2'
    click_link 'chapter_characters'
    click_link 'Bob'
    click_link 'View'
    click_link 'Back'
    page.should have_content('T_Chapter_1')
    click_link 'Bob'
    click_link 'Edit'
    click_link 'Back'
    page.should have_content('T_Chapter_1')
    click_link 'Bob'
    click_link 'XP Track'
    click_link 'Back'
    page.should have_content('T_Chapter_1')
    click_link 'Bob'
    click_link 'Back'
    page.should have_content('T_Chapter_1')
  end

end