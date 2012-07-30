require "spec_helper"

describe "basic navigation" do
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"
  end

  it "should be able to create a nem Member" do
    visit "chapters/1"
    #click_link "Chapter Players"
    click_link "New Member"
    fill_in "Email", with: "new_test@test.com"
    fill_in "First name", with: "Jane"
    fill_in "Last name", with: "Doe"
    fill_in "Password", with: "txt@1234"
    fill_in "Password confirmation", with: "txt@1234"
    click_button "Add Member"
    #save_and_open_page
    page.should have_content("new_test@test.com Jane Doe")
  end

  it "should give good errors with bad fields" do
    visit "chapters/1"
    click_link "New Member"
    click_button "Add Member"

    page.should have_content("Please review the problems below:")
  end

  # it "should be able to delete a user" do
  #   click_link "Players"
  #   click_link "Delete"
  #   #save_and_open_page
  #   #click_button "OK"
  #   page.should_not have_content("admin@test.com")
  #   page.should have_content("Remember me")
  # end

end