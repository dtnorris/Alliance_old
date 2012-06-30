require 'spec_helper'

describe "character" do
  let(:new_character) { Character.create(id: 1, name: 'Bob', race_id: 11, char_class_id: 1, experience_points: 0, build_points: 15) }

  it "purchases racial skills on create" do
    CharacterSkill.find_all_by_character_id(new_character.id).count.should == 0
    nc1 = Character.create(id: 1, name: 'Bob', race_id: 1, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc1.id).count.should == 2
    nc2 = Character.create(id: 2, name: 'Bob', race_id: 2, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc2.id).count.should == 2
    nc3 = Character.create(id: 3, name: 'Bob', race_id: 3, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc3.id).count.should == 2
    nc4 = Character.create(id: 4, name: 'Bob', race_id: 4, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc4.id).count.should == 1
    nc5 = Character.create(id: 5, name: 'Bob', race_id: 5, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc5.id).count.should == 2
    nc6 = Character.create(id: 6, name: 'Bob', race_id: 6, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc6.id).count.should == 1
    nc7 = Character.create(id: 7, name: 'Bob', race_id: 7, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc7.id).count.should == 1
    nc8 = Character.create(id: 8, name: 'Bob', race_id: 8, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc8.id).count.should == 2
    nc9 = Character.create(id: 9, name: 'Bob', race_id: 9, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc9.id).count.should == 3
    nc10 = Character.create(id: 10, name: 'Bob', race_id: 10, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc10.id).count.should == 2
    nc12 = Character.create(id: 12, name: 'Bob', race_id: 12, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc12.id).count.should == 2
    nc13 = Character.create(id: 13, name: 'Bob', race_id: 13, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc13.id).count.should == 2
    nc14 = Character.create(id: 14, name: 'Bob', race_id: 14, char_class_id: 1, experience_points: 0, build_points: 15)
    CharacterSkill.find_all_by_character_id(nc14.id).count.should == 2
  end

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
    CharacterSkill.add_skill(new_character.id, 2) #3
    CharacterSkill.add_skill(new_character.id, 2) #3
    CharacterSkill.add_skill(new_character.id, 29) #5
    CharacterSkill.add_skill(new_character.id, 29) ##
    CharacterSkill.add_skill(new_character.id, 8) #3
    CharacterSkill.add_skill(new_character.id, 7) #10
    new_character.calculate_spent_build.should == 0

    CharacterSkill.purchase_skill(new_character.id, 2) #3
    CharacterSkill.purchase_skill(new_character.id, 2) #3
    CharacterSkill.purchase_skill(new_character.id, 29) #5
    CharacterSkill.purchase_skill(new_character.id, 29) ##
    CharacterSkill.purchase_skill(new_character.id, 8) #3
    CharacterSkill.purchase_skill(new_character.id, 7) #10
    new_character.calculate_spent_build.should == 24
  end

end