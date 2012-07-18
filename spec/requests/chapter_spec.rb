require "spec_helper"

describe "basic navigation" do
  before :each do
    visit "/"
    fill_in "user_email", with: "dreamingfurther@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"
    visit "/chapters"
  end

  it "should not be able to create a new chapter without fields" do
    click_link "New Chapter"
    click_button "Create Chapter"
    page.should have_content("Please review the problems below:") 
  end

  it "should be able to edit an existing chapter" do
    click_link "Edit"
    fill_in "Owner", with: "Gary Marvel"
    click_button "Update Chapter"
    page.should have_content("Owner: Gary Marvel")
  end
  
end