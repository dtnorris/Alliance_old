require "spec_helper"

describe "chapter navigation" do
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"
    visit "/chapters"
  end

  it 'should be able to edit current member blanket status' do 
    click_link 'T_Chapter_1'
    click_link 'List'
    click_link 'Alliance Admin'
    select 'Bob', from: 'Character to Blanket:'
    check 'Blanket list'
    click_button 'Modify Blanket Settings'
    page.should have_content 'Member was successfully updated.'
    page.should have_content 'Alliance Admin Bob Yes 0'
  end

  it 'should add members on the blanket list to new monthly blankets' do 
    click_link 'T_Chapter_1'
    click_link 'List'
    click_link 'Alliance Admin'
    select 'Bob', from: 'Character to Blanket:'
    check 'Blanket list'
    click_button 'Modify Blanket Settings'
    click_link 'New'
    click_button 'Create Event'
    page.should have_content 'Blanket was successfully created'

    click_link 'View Attendees'
    page.should have_content 'Alliance Admin NPC Bob 1 false Apply Event'

    click_link 'Back'
    click_link 'T_Chapter_1'
    click_link 'Apply - No'
    page.should have_content 'Monthly Blanket applied'
    click_link 'View Attendees'
    page.should have_content 'Alliance Admin NPC Bob 1 false Apply Event'

    click_link 'Apply Event'
    page.should have_content 'Error applying event blanket'
  end

  it 'should not apply blankets to characters whos users do not have enough goblin stamps' do 
    click_link 'T_Chapter_1'
    click_link 'List'
    click_link 'Alliance Admin'
    select 'Bob', from: 'Character to Blanket:'
    check 'Blanket list'
    click_button 'Modify Blanket Settings'
    click_link 'New'
    click_button 'Create Event'
    click_link 'View Attendees'
    click_link 'Apply Event'
    page.should have_content 'Error applying event blanket'
  end

  it 'should apply blankets to characters whos users have enough goblin stamps' do 
    ch = Character.find_by_name('Bob')
    mb = Member.find_by_chapter_id_and_user_id(ch.chapter.id, ch.user.id)
    mb.goblin_stamps = 1000
    mb.save
    click_link 'T_Chapter_1'
    click_link 'List'
    click_link 'Alliance Admin'
    select 'Bob', from: 'Character to Blanket:'
    check 'Blanket list'
    click_button 'Modify Blanket Settings'
    click_link 'New'
    click_button 'Create Event'
    click_link 'Apply - No'
    click_link 'View Attendees'
    page.should have_content 'Alliance Admin NPC Bob 1 true'
  end

  it 'should display total characters on chapter home page' do 
    click_link 'T_Chapter_1'
    page.should have_content('Number of Characters: 1')
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