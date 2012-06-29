require 'spec_helper'

describe "character" do
  let(:new_character) { Character.create(id: 1, name: 'Bob', race_id: 11, char_class_id: 1, experience_points: 0, build_points: 15) }

  it "updates body points on save" do
    new_character.body_points == 6
  end

  it "can calculate adding xp" do
    new_character.add_xp(2, "Test Weekend")
    new_character.experience_points.should == 30
  end

  it "should calculate updated build based on xp before save" do
    new_character.add_xp(2, "Test Weekend")
    new_character.save 
    new_character.build_points.should == 25
  end

  it "should calculate spent build off asociated skills" do
    CharacterSkill.add_skill(new_character.id, 1) #6
    CharacterSkill.add_skill(new_character.id, 1) #6
    CharacterSkill.add_skill(new_character.id, 2) #3
    CharacterSkill.add_skill(new_character.id, 8) #3
    CharacterSkill.add_skill(new_character.id, 8) ##
    CharacterSkill.add_skill(new_character.id, 7) #10
    new_character.calculate_spent_build.should == 0

    CharacterSkill.purchase_skill(new_character.id, 1) #6
    CharacterSkill.purchase_skill(new_character.id, 1) #6
    CharacterSkill.purchase_skill(new_character.id, 2) #3
    CharacterSkill.purchase_skill(new_character.id, 8) #3
    CharacterSkill.purchase_skill(new_character.id, 8) ##
    CharacterSkill.purchase_skill(new_character.id, 7) #10
    new_character.calculate_spent_build.should == 28
  end

end