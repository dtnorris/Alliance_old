require "spec_helper"

describe "basic navigation" do
  it "allows a user to view main tab" do
    visit "/"
    page.should have_content("Welcome to the Alliance Character Managent Tool")
  end

  it "allows a user to view Character tab" do
    visit "/characters"
    page.should have_content("Listing Characters")
  end

  it "allows a user to view Chapter tab" do
    visit "/chapters"
    page.should have_content("Build:")
    page.should have_content("XP:")
  end

end