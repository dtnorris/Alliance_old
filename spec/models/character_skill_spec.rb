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
    cs = FactoryGirl.create(:character_skill, character_id: character.id, skill_id: Skill.find_by_name(skill).id, bought: bought, amount: amount)
    cs.save
  end

  it 'sells back other skills when I purchase One Handed master' do  
    purchase_skill hb_char, 'One Handed Edged', true, nil
    purchase_skill hb_char, 'One Handed Blunt', true, nil
    purchase_skill hb_char, 'Small Weapon', true, nil
    hb_char.save
    hb_char.spent_build.should == 10

    wpm = CharacterSkill.add_skill(hb_char.id, Skill.find_by_name('One Handed Master').id)
    CharacterSkill.purchase_skill(wpm)
    hb_char.save
    hb_char.spent_build.should == 7
  end

  it 'sells back other skills when I purchase Two Handed master' do
    purchase_skill hb_char, 'Polearm', true, nil
    purchase_skill hb_char, 'Staff', true, nil
    purchase_skill hb_char, 'Two Handed Blunt', true, nil
    purchase_skill hb_char, 'Two Handed Sword', true, nil
    hb_char.save
    hb_char.spent_build.should == 26

    wpm = CharacterSkill.add_skill(hb_char.id, Skill.find_by_name('Two Handed Master').id)
    CharacterSkill.purchase_skill(wpm)
    hb_char.save
    hb_char.spent_build.should == 10
  end

  it 'sells back other master skills when I purchase Weapon Master' do 
    purchase_skill hb_char, 'One Handed Master', true, nil
    purchase_skill hb_char, 'Two Handed Master', true, nil
    hb_char.save
    hb_char.spent_build.should == 17

    wpm = CharacterSkill.add_skill(hb_char.id, Skill.find_by_name('Weapon Master').id)
    CharacterSkill.purchase_skill(wpm)
    hb_char.save
    hb_char.spent_build.should == 15
  end

  it 'sells back included skills when I purchase Weapon Master' do 
    purchase_skill hb_char, 'One Handed Edged', true, nil
    purchase_skill hb_char, 'One Handed Blunt', true, nil
    purchase_skill hb_char, 'Small Weapon', true, nil
    purchase_skill hb_char, 'Polearm', true, nil
    purchase_skill hb_char, 'Staff', true, nil
    purchase_skill hb_char, 'Two Handed Blunt', true, nil
    purchase_skill hb_char, 'Two Handed Sword', true, nil
    hb_char.save
    hb_char.spent_build.should == 36
    wpm = CharacterSkill.add_skill(hb_char.id, Skill.find_by_name('Weapon Master').id)
    CharacterSkill.purchase_skill(wpm)
    hb_char.save
    hb_char.spent_build.should == 15
  end

  it 'sells back other skills when I purchase Style Master' do
    purchase_skill hb_char, 'Small Weapon', true, nil
    purchase_skill hb_char, 'Florentine', true, nil
    purchase_skill hb_char, 'Two Weapons', true, nil
    purchase_skill hb_char, 'Shield', true, nil
    hb_char.save
    hb_char.spent_build.should == 14

    wpm = CharacterSkill.add_skill(hb_char.id, Skill.find_by_name('Style Master').id)
    CharacterSkill.purchase_skill(wpm)
    hb_char.save
    hb_char.spent_build.should == 12
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
