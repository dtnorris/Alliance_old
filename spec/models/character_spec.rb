require 'spec_helper'

describe "character" do
  let(:char) { FactoryGirl.create(:character) }

  it "it adds xp tracking when calling update_xp_and_build" do
    XpTrack.all.count.should == 0
    char.add_xp(1, "Test One Day")
    xp = XpTrack.all.first
    
    XpTrack.all.count.should == 1
    xp.character_id.should == 1
    xp.start_xp.should == 0
    xp.end_xp.should == 15
    xp.start_build.should == 15
    xp.end_build.should == 20
    xp.reason.should == "Test One Day"
  end

  it "updates body points on save" do
    char.body_points == 6
  end

  it "can calculate adding xp" do
    char.add_xp(2, "Test Weekend")
    char.experience_points.should == 30
  end

  it "should calculate updated build based on xp before save" do
    char.add_xp(2, "Test Weekend")
    char.save 
    char.build_points.should == 25
  end

  it "should calculate spent build off asociated skills" do
    CharacterSkill.add_skill(char.id, 2) #3
    CharacterSkill.add_skill(char.id, 2) #3
    CharacterSkill.add_skill(char.id, 29) #5
    CharacterSkill.add_skill(char.id, 29) ##
    CharacterSkill.add_skill(char.id, 8) #3
    CharacterSkill.add_skill(char.id, 7) #10
    char.calculate_spent_build.should == 0

    CharacterSkill.purchase_skill(char.id, 2) #3
    CharacterSkill.purchase_skill(char.id, 2) #3
    CharacterSkill.purchase_skill(char.id, 29) #5
    CharacterSkill.purchase_skill(char.id, 29) ##
    CharacterSkill.purchase_skill(char.id, 8) #3
    CharacterSkill.purchase_skill(char.id, 7) #10
    char.calculate_spent_build.should == 24
  end

  it "purchases racial skills on create" do
    CharacterSkill.find_all_by_character_id(char.id).count.should == 0
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

end