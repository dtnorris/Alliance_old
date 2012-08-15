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
    fill_in "Character Name:", with: "Bob"
    select("Human", :from => "Race:")
    select("Fighter", :from => "Character Class:")
    click_button "Create Character"
  end

  it "should have an add death form" do
    click_link "Edit"
    page.should have_content("Buyback?")
    page.should have_content("Regen/CSS?")
  end

  it "should be able to add all regular deaths" do
    click_link "Edit"
    click_button "Add Death"
    page.should have_content('Death was successfully created')
    click_link "View"
    page.should have_content("Deaths: 1")
  end

  it 'should be able to add Buyback deaths' do
    click_link "Edit"
    check('Buyback?')
    click_button "Add Death"
    page.should have_content('Death buyback was successfully created')
    click_link "View"
    page.should have_content('Deaths Bought Back: 1')
  end

  it 'should be able to add Regen_CSS deaths' do
    click_link "Edit"
    check('Regen/CSS?')
    click_button "Add Death"
    page.should have_content('Regen/CSS Death was successfully created')
    click_link "View"
    page.should have_content('Regen/CSS Deaths: 1')
  end

  it 'should be able to visit death tracking page' do
    click_link "Edit"
    click_button "Add Death"
    check('Buyback?')
    click_button "Add Death"
    check('Regen/CSS?')
    click_button "Add Death"
    click_link "Death Track"
    page.should have_content('Back')
    page.should have_content('Death Tracking for Bob')

    page.should have_content('Deaths Bought Back: 1')
    page.should have_content('Regular Deaths: 1')
    page.should have_content('Deaths Regen/CSS: 1')
    page.should have_content('On')
    page.should have_content('X')
  end

end
