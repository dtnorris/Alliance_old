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
    page.should have_content("Characters for T_Chapter_1")
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
    page.should have_content("Home For: Alliance Admin")
  end



end