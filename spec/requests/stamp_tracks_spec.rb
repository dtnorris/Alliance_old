require "spec_helper"

describe "basic navigation" do
  before :each do
    visit "/"
    fill_in "user_email", with: "dreamingfurther@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"
  end

  it "should be able to add goblin stamps" do
    visit "/chapters/1"
    click_link "Add/Remove"

    fill_in "Amount to change", with: "1000"
    fill_in "Reason", with: "test goblin stamp add"
    click_button "Add/Remove Goblin Stamps"
    click_link "dreamingfurther@test.com"
    page.should have_content("Caldaria 1000")
  end
end