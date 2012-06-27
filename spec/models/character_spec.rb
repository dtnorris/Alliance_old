require 'spec_helper'

describe Character do
  let(:new_character) do
    new_character = Character.create 
    new_character.build_points = 15
    new_character.experience_points = 0
    new_character.char_class_id = 1
    new_character
  end

  it "can calculate adding xp" do
    new_character.add_xp(2)
    new_character.experience_points.should == 30
  end

  it "should calculate updated build based on xp before save" do
    new_character.add_xp(2)
    new_character.save 
    new_character.build_points.should == 25
  end

  it "should calculate spent build off asociated skills" do
    CharacterSkill.add_or_update_skill(new_character.id, 1) #6
    CharacterSkill.add_or_update_skill(new_character.id, 1) #6
    CharacterSkill.add_or_update_skill(new_character.id, 2) #3
    CharacterSkill.add_or_update_skill(new_character.id, 8) #3
    CharacterSkill.add_or_update_skill(new_character.id, 8) ##
    CharacterSkill.add_or_update_skill(new_character.id, 7) #10
    new_character.calculate_spent_build.should == 28
  end

end