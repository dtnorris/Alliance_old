require 'spec_helper'

describe 'Ability' do
  let!(:player) { FactoryGirl.create(:user, email: 'player@test.com', first_name: 'john', last_name: 'doe', password: 'txt@1234', password_confirmation: 'txt@1234') }
  let!(:chapter) { FactoryGirl.create(:chapter, name: 'Steel', owner: 'The Boss', email: 'tb@test.com', location: 'TBD')}
  let!(:p_char) { FactoryGirl.create(:character, user_id: player.id, home_chapter: 1, name: 'Garth', race_id: 1, char_class_id: 1)}

  describe 'player permissions' do
    before :each do
      visit '/'
      fill_in 'user_email', with: 'player@test.com'
      fill_in 'user_password', with: 'txt@1234'
      click_button 'Sign in'
    end

    it 'should not be able to go to chapters page' do
      visit '/chapters'
      page.should have_content('Access denied')
      page.should_not have_content('Alliance Chapters')
    end

    it 'should not be able to go to a specific chapter page' do
      visit '/chapters/1'
      page.should have_content('Access denied')      
    end

    it 'should not be able to go to events page' do
      visit '/events'
      page.should have_content('Access denied')
      page.should_not have_content('Alliance Chapters')
    end

    it 'should not be able to go to users page' do
      visit '/users'
      page.should have_content('Access denied')
      page.should_not have_content('Alliance Chapters')
    end

    it 'should not be able to go to characters page' do
      visit '/characters'
      page.should have_content('Access denied')
      page.should_not have_content('Alliance Chapters')
    end

    it 'should be able to view characters' do
      within('#character_table') do
        click_link 'View'
      end
      page.should have_content('Name: Garth')
      page.should have_content('View')
      page.should have_content('XP Track')
      page.should_not have_content('Edit')
    end

    it 'should be able to view character xp track' do
      within('#character_table') do
        click_link 'View'
      end
      click_link 'XP Track'
      page.should have_content('Experience Point Tracking for: Garth')
      page.should have_content('Start Build: Final Build: Build Gained: Start XP: Final XP: Reason Added:')
    end
  end

end