require "spec_helper"

describe "basic navigation" do
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"

    visit "chapters/new"
    fill_in "Owner", with: "Dave Glaiser"
    fill_in "Email", with: "mnalliance@test.com"
    fill_in "Name", with: "Gaden"
    fill_in "Location", with: "SoMN"
    click_button "Create Chapter"
  end

  it "should be able to add new membership" do
    click_link "admin@test.com"
    click_link "Edit"
    select("Gaden", :from => "Chapter")
    click_button "Add Membership"
    page.should have_content("Gaden")

    select("Gaden", :from => "Chapter")
    click_button "Add Membership"
    page.should_not have_content("Gaden/\n/\n0/\n/\n/\n/\nGaden/\n/\n0")
  end

end

