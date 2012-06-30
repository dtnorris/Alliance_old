require 'spec_helper'

describe CharacterSkill do
  let!(:char) { Character.create(id: 1, race_id: 11, char_class_id: 1, experience_points: 0, build_points: 15) }
  let!(:skill_smith) { Skill.find(2) }
  let!(:skill_shield) { Skill.find(32) }

  it "can add_skill" do
    CharacterSkill.all.count.should == 0
    CharacterSkill.add_skill(char.id, skill_smith.id)
    CharacterSkill.all.count.should == 1
    CharacterSkill.add_skill(char.id, skill_smith.id)
    CharacterSkill.all.count.should == 1
    CharacterSkill.add_skill(char.id, skill_shield.id)
    CharacterSkill.all.count.should == 2
    CharacterSkill.add_skill(char.id, skill_shield.id)
    CharacterSkill.all.count.should == 2
  end

  it "can purchase_skill" do
    CharacterSkill.add_skill(char.id, skill_smith.id)
    CharacterSkill.add_skill(char.id, skill_smith.id)
    CharacterSkill.add_skill(char.id, skill_shield.id)
    CharacterSkill.add_skill(char.id, skill_shield.id)
    
    CharacterSkill.purchase_skill(char.id, skill_smith.id)
    CharacterSkill.purchase_skill(char.id, skill_shield.id)
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
