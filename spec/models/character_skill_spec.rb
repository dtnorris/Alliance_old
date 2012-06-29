require 'spec_helper'

describe CharacterSkill do
  let(:char) { Character.create(race_id: 11, char_class_id: 1, experience_points: 0, build_points: 15) }
  let!(:skill_alch) { Skill.find(1) }
  let!(:skill_herb) { Skill.find(6) }

  it "can add_skill" do
    CharacterSkill.all.count.should == 0
    CharacterSkill.add_skill(char.id, skill_alch.id)
    CharacterSkill.all.count.should == 1
    CharacterSkill.add_skill(char.id, skill_alch.id)
    CharacterSkill.all.count.should == 1
    CharacterSkill.add_skill(char.id, skill_herb.id)
    CharacterSkill.all.count.should == 2
    CharacterSkill.add_skill(char.id, skill_herb.id)
    CharacterSkill.all.count.should == 2
  end

  it "can purchase_skill" do
    CharacterSkill.add_skill(char.id, skill_alch.id)
    CharacterSkill.add_skill(char.id, skill_alch.id)
    CharacterSkill.add_skill(char.id, skill_herb.id)
    CharacterSkill.add_skill(char.id, skill_herb.id)

    CharacterSkill.purchase_skill(char.id, skill_alch.id)
    CharacterSkill.purchase_skill(char.id, skill_herb.id)
    CharacterSkill.find_by_skill_id(skill_alch.id).amount.should == 1
    CharacterSkill.find_by_skill_id(skill_herb.id).bought.should == true
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
