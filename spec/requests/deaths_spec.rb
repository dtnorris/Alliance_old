require 'spec_helper'

describe "Deaths" do
  before :each do
    visit "/"
    fill_in "user_email", with: "admin@test.com"
    fill_in "user_password", with: "txt@1234"
    click_button "Sign in"

    visit "/chapters/1"
    click_link "chapter_players"
    click_link "New Character"
    fill_in "Character Name:", with: "Bill"
    select("Human", :from => "Race:")
    select("Fighter", :from => "Character Class:")
    click_button "Create Character"
  end

  it 'adding a death does not mess up routing' do 
    click_link 'Edit'
    click_button 'add_death'
    click_link 'Back'
    page.should have_content 'T_Chapter_1'

    click_link 'Characters'
    click_link 'Bob'
    click_button 'add_death'
    click_link 'Back'
    page.should have_content 'T_Chapter_1'
  end

  it "should have an add death form" do
    click_link "Edit"
    find_button('Add Death').should be_true
    find_button('Buyback Death').should be_true
    find_button('Add Regen/CSS Death').should be_true
  end

  it "should be able to add all regular deaths" do
    click_link "Edit"
    click_button 'add_death'
    page.should have_content('Death was successfully created')
    click_link "View"
    page.should have_content("Deaths: 1")
  end

  it 'should be able to add Buyback deaths' do
    click_link "Edit"
    click_button 'buyback_death'
    page.should have_content('Death buyback was successfully created')
    click_link "View"
    page.should have_content('Deaths Bought Back: 1')
  end

  it 'should be able to add Regen_CSS deaths' do
    click_link "Edit"
    click_button 'add_regen_css_death'
    page.should have_content('Regen/CSS Death was successfully created')
    click_link "View"
    page.should have_content('Regen/CSS Deaths: 1')
  end

  it 'should be able to visit death tracking page' do
    click_link "Edit"
    click_button "Add Death"
    click_button 'Buyback Death'
    click_button 'Add Regen/CSS Death'
    click_link "Death Track"
    page.should have_content('Back')
    page.should have_content('Death Tracking for Bill')

    page.should have_content('Deaths Bought Back: 1')
    page.should have_content('Regular Deaths: 1')
    page.should have_content('Deaths Regen/CSS: 1')
    page.should have_content('On')
    page.should have_content('X')
  end

end
