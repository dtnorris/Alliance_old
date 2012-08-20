require 'spec_helper'

describe "CharacterSkill" do
  let!(:char) { Character.create(id: 1, race_id: 11, char_class_id: 1, experience_points: 0, build_points: 15) }
  let!(:skill_smith) { Skill.find(2) }
  let!(:skill_shield) { Skill.find(32) }

  let(:hb_char) do 
    hb = FactoryGirl.create(:character)
    hb.experience_points = 100000
    hb.build_points = 150
    hb.save
    hb
  end

  def purchase_skill character, skill, bought=nil, amount=nil
    FactoryGirl.create(:character_skill, character_id: character.id, skill_id: Skill.find_by_name(skill).id, bought: bought, amount: amount)
  end

  it "can determine character spells" do
    purchase_skill hb_char, 'Celestial Level 1', nil, 0
    purchase_skill hb_char, 'Celestial Level 2', nil, 0
    purchase_skill hb_char, 'Earth Level 1', nil, 0

    CharacterSkill.all_spells(hb_char,'Earth').count.should == 1
    CharacterSkill.all_spells(hb_char,'Celestial').count.should == 2
  end
  
  it "can determine all racials" do
    CharacterSkill.all_racials(hb_char).count.should == 0
  end

  it "can add_skill" do
    CharacterSkill.find_all_by_character_id(char.id).count.should == 0
    CharacterSkill.add_skill(char.id, skill_smith.id)
    CharacterSkill.find_all_by_character_id(char.id).count.should == 1
    CharacterSkill.add_skill(char.id, skill_smith.id)
    CharacterSkill.find_all_by_character_id(char.id).count.should == 1
    CharacterSkill.add_skill(char.id, skill_shield.id)
    CharacterSkill.find_all_by_character_id(char.id).count.should == 2
    CharacterSkill.add_skill(char.id, skill_shield.id)
    CharacterSkill.find_all_by_character_id(char.id).count.should == 2
  end

  it "can purchase_skill" do
    cs1 = CharacterSkill.add_skill(char.id, skill_smith.id)
    cs2 = CharacterSkill.add_skill(char.id, skill_shield.id)
    
    CharacterSkill.purchase_skill(cs1)
    CharacterSkill.purchase_skill(cs2)
    CharacterSkill.find_by_skill_id(skill_smith.id).amount.should == 1
    CharacterSkill.find_by_skill_id(skill_shield.id).bought.should == true
  end

  it "can list all bought skills" do
    CharacterSkill.add_skill(char.id, 1) #6
    CharacterSkill.add_skill(char.id, 1) #6
    CharacterSkill.add_skill(char.id, 2) #3
    CharacterSkill.add_skill(char.id, 8) #3
    CharacterSkill.add_skill(char.id, 8) ##
    CharacterSkill.add_skill(char.id, 7) #10
    CharacterSkill.all_bought_skills(char).count.should == 4
  end

end
