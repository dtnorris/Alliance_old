require 'spec_helper'

describe Death do
  let!(:chap) { FactoryGirl.create(:chapter) }
  let!(:char) { FactoryGirl.create(:character) }
  let!(:death1) { FactoryGirl.create(:death, character_id: char.id, chapter_id: chap.id) }
  let!(:death2) { FactoryGirl.create(:death, character_id: char.id, chapter_id: chap.id) }
  let!(:death3) { FactoryGirl.create(:death, character_id: char.id, chapter_id: chap.id) }
  let!(:death4) { FactoryGirl.create(:death, character_id: char.id, chapter_id: chap.id, regen_css: true) }
  let!(:death5) { FactoryGirl.create(:death, character_id: char.id, chapter_id: chap.id, buyback: true) }
  let!(:death6) { FactoryGirl.create(:death, character_id: char.id, chapter_id: chap.id, buyback: true) }
  
  it "should calculate regular deaths" do
    Death.regular(char.deaths).should == 3
  end

  it "should calculate regen_css deaths" do
    Death.regen_css(char.deaths).should == 1
  end

  it "should calculate buyback deaths" do
    Death.buyback(char.deaths).should == 2
  end
end
