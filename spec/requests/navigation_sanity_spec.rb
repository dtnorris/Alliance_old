require "spec_helper"

describe "basic navigation" do
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"
  end

  it "should allow a chapter to view chapter characters" do
    click_link "Chapters"
    click_link "Home"
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
    visit '/chapters/1'
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