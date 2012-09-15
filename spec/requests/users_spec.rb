require "spec_helper"

describe "basic navigation" do
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"
  end

  it 'should display an error when password doesn''t update' do 
    click_link 'Profile info'
    click_link 'Change Password'
    fill_in 'New password', with: 'tmp@2345'
    click_button 'Change my password'
    page.should have_content 'Error updating password.'
  end

  it 'should be able to change my password' do
    click_link 'Profile info'
    click_link 'Change Password'
    fill_in 'New password', with: 'tmp@2345'
    fill_in 'Confirm your new password', with: 'tmp@2345'
    click_button 'Change my password'
    page.should have_content 'Password successfully updated.'

    click_link 'Log Out'
    fill_in 'Email', with: 'admin@test.com' 
    fill_in 'Password', with: 'tmp@2345'
    click_button 'Sign in'
    page.should have_content 'Signed in successfully.'
  end

  it "should be able to edit myself" do
    click_link "Profile info"
    fill_in "Email", with: "actual@test.com"
    click_button "Update User"
    page.should have_content("User was successfully updated.")
  end

  it "should be able to create a nem Member" do
    visit "chapters/1"
    click_link "New Member"
    fill_in "Email", with: "new_test@test.com"
    fill_in "First name", with: "Jane"
    fill_in "Last name", with: "Doe"
    fill_in "Password", with: "txt@1234"
    fill_in "Password confirmation", with: "txt@1234"
    select 'Player', from: 'Role'
    click_button "Add Member"
    #save_and_open_page
    page.should have_content("Jane Doe No new_test@test.com")
  end

  it "should give good errors with bad fields" do
    visit "chapters/1"
    click_link "New Member"
    click_button "Add Member"

    page.should have_content("* Password confirmation")
  end

end