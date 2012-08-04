require 'spec_helper'

describe "character" do
  describe "import functions" do
    before :each do
      Chapter.data_import({ name: 'Southern Minnesota', owner: 'David Glaiser', email: 'dg@test.com', location: 'soMN' })
      user_data = DataImport.user_import("#{Rails.root}/data/test_members.csv")
      User.data_import(user_data, 'soMN')
    end

    it "should import characters from csv" do
      char_data = DataImport.character_import("#{Rails.root}/data/test_characters.csv")
      Character.data_import(char_data, 'soMN')
      Character.all.count.should == 3
    end
  end

  describe "basic functions" do
    let!(:char) { FactoryGirl.create(:character) }
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

    it "can purchase per_day_skills" do
      purchase_skill hb_char, 'Back Attack', nil, 0
      purchase_skill hb_char, 'Critical Attack', nil, 0

      hb_char.per_day_skills.count.should == 2
    end

    it "can display continuous_skills" do
      purchase_skill hb_char, 'One Handed Blunt', false
      purchase_skill hb_char, 'One Handed Edged', false

      hb_char.continuous_skills.count.should == 2
    end

    it "can display per_day_skills" do
    end

    it "updates body points on save" do
      char.body_points == 6
    end

    it "can calculate adding xp" do
      char.add_xp(2, "Test Weekend")
      char.experience_points.should == 30
    end

    it "should calculate spent build off asociated skills" do
      CharacterSkill.add_skill(hb_char.id, 2) #3
      CharacterSkill.add_skill(hb_char.id, 2) #3
      CharacterSkill.add_skill(hb_char.id, 29) #5
      CharacterSkill.add_skill(hb_char.id, 29) ##
      CharacterSkill.add_skill(hb_char.id, 8) #3
      CharacterSkill.add_skill(hb_char.id, 7) #10
      hb_char.calculate_spent_build.should == 0

      CharacterSkill.purchase_skill(hb_char.id, 2) #3
      CharacterSkill.purchase_skill(hb_char.id, 2) #3
      CharacterSkill.purchase_skill(hb_char.id, 29) #5
      CharacterSkill.purchase_skill(hb_char.id, 29) ##
      CharacterSkill.purchase_skill(hb_char.id, 8) #3
      CharacterSkill.purchase_skill(hb_char.id, 7) #10
      hb_char.calculate_spent_build.should == 24
    end

    it "purchases racial skills on create" do
      CharacterSkill.find_all_by_character_id(char.id).count.should == 0
      nc1 = Character.create(id: 1, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 1, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc1.id).count.should == 2
      nc2 = Character.create(id: 2, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 2, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc2.id).count.should == 2
      nc3 = Character.create(id: 3, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 3, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc3.id).count.should == 2
      nc4 = Character.create(id: 4, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 4, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc4.id).count.should == 1
      nc5 = Character.create(id: 5, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 5, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc5.id).count.should == 2
      nc6 = Character.create(id: 6, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 6, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc6.id).count.should == 1
      nc7 = Character.create(id: 7, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 7, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc7.id).count.should == 1
      nc8 = Character.create(id: 8, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 8, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc8.id).count.should == 2
      nc9 = Character.create(id: 9, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 9, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc9.id).count.should == 3
      nc10 = Character.create(id: 10, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 10, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc10.id).count.should == 2
      nc12 = Character.create(id: 12, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 12, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc12.id).count.should == 2
      nc13 = Character.create(id: 13, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 13, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc13.id).count.should == 3
      nc14 = Character.create(id: 14, home_chapter: 'T_Chapter_1', user_id: 1, name: 'Bob', race_id: 14, char_class_id: 1, experience_points: 0, build_points: 15)
      CharacterSkill.find_all_by_character_id(nc14.id).count.should == 2
    end
  end
end