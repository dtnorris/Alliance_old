require "spec_helper"

describe "skill validation" do
  #let!(:char) { Character.create(id: 1, race_id: 11, char_class_id: 1, experience_points: 10000, build_points: 150) }
  let!(:char) do 
    hb = FactoryGirl.create(:character)
    hb.experience_points = 100000
    hb.build_points = 150
    hb.save
    hb
  end

  def validate_one_pre_req(skill, pre_req, amount=1)
    skill = Skill.find_by_name(skill)
    pre_req = Skill.find_by_name(pre_req)
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == false
    pr = CharacterSkill.add_skill(char.id, pre_req.id)
    pr.bought = true
    pr.amount = amount
    pr.save
    CharacterSkill.purchase_skill(char.id, skill.id)
  end

  def validate_race_pre_req(skill, race)
    skill = Skill.find_by_name(skill)
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == false
    char.race_id = Race.find_by_name(race).id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id)
  end

  it "can validate non-dependant skill purchse" do
    skill = Skill.find_by_name('Blacksmith')
    CharacterSkill.add_skill(char.id, skill.id)
    sk = CharacterSkill.purchase_skill(char.id, skill.id)
    sk.amount.should == 1
  end
  it "can validate Alchemy purchase" do
    validate_one_pre_req('Alchemy', 'Herbal Lore').amount.should == 1
  end
  it "can validate Create Potion purchase" do
    validate_one_pre_req('Create Potion', 'Earth Level 1').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Create Scroll', 'Celestial Level 1').amount.should == 1
  end
  it "can validate Create Trap purchase" do
    validate_one_pre_req('Create Trap', 'Legerdemain').amount.should == 1
  end
  it "can validate Herbal Lore purchase" do
    validate_one_pre_req('Herbal Lore', 'Read And Write').bought.should == true
  end
  it "can validate Read Magic purchase" do
    validate_one_pre_req('Read Magic', 'Read And Write').bought.should == true
  end
  it "can validate Healing Arts purchase" do
    skill = Skill.find_by_name('Healing Arts')
    skill1 = Skill.find_by_name('Read And Write')
    skill2 = Skill.find_by_name('First Aid')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == false
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.add_skill(char.id, skill2.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill2.id)
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Style Master purchase" do
    validate_one_pre_req('Style Master', 'One Handed Master').bought.should == true
  end
  it "can validate Back Attack purchase" do
    validate_one_pre_req('Back Attack', 'One Handed Blunt').amount.should == 1
  end
  it "can validate Critical Attack purchase" do
    validate_one_pre_req('Critical Attack', 'One Handed Edged').amount.should == 1
  end
  it "can validate Two Weapons purchase" do
    validate_one_pre_req('Two Weapons', 'Florentine').bought.should == true
  end
  it "can validate Assassinate purchase" do
    validate_one_pre_req('Assassinate', 'Backstab', 2).amount.should == 1
  end
  it "can validate Dodge purchase" do
    validate_one_pre_req('Dodge', 'Backstab', 2).amount.should == 1
  end
  it "can validate Disarm purchase" do
    validate_one_pre_req('Disarm', 'Backstab', 1).amount.should == 1
  end
  it "can validate Evade purchase" do
    validate_one_pre_req('Evade', 'Backstab', 1).amount.should == 1
  end
  it "can validate Parry purchase" do
    validate_one_pre_req('Parry', 'Weapon Proficiency', 2).amount.should == 1
  end
  it "can validate Slay purchase" do
    validate_one_pre_req('Slay', 'Weapon Proficiency', 2).amount.should == 1
  end
  it "can validate Riposte purchase" do
    validate_one_pre_req('Riposte', 'Weapon Proficiency', 4).amount.should == 1
  end
  it "can validate Shatter purchase" do
    validate_one_pre_req('Shatter', 'Backstab', 3).amount.should == 1
  end
  it "can validate Stun Limb purchase" do
    validate_one_pre_req('Shatter', 'Weapon Proficiency', 3).amount.should == 1
  end
  it "can validate Terminate purchase" do
    validate_one_pre_req('Terminate', 'Backstab', 4).amount.should == 1
  end
  it "can validate Eviscerate purchase" do
    validate_one_pre_req('Eviscerate', 'Weapon Proficiency', 4).amount.should == 1
  end
  it "can validate Backstab purchase" do
    validate_one_pre_req('Backstab', 'Back Attack', 4).amount.should == 1
    CharacterSkill.find_by_character_id_and_skill_id(char.id, Skill.find_by_name('Back Attack').id).amount.should == 0
  end
  it "can validate Weapon Proficiency purchase" do
    validate_one_pre_req('Weapon Proficiency', 'Critical Attack', 4).amount.should == 1
    CharacterSkill.find_by_character_id_and_skill_id(char.id, Skill.find_by_name('Critical Attack').id).amount.should == 0
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Celestial Level 1', 'Read Magic').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Celestial Level 2', 'Celestial Level 1').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Celestial Level 3', 'Celestial Level 2').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Celestial Level 4', 'Celestial Level 3').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Celestial Level 5', 'Celestial Level 4').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Celestial Level 6', 'Celestial Level 5').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Celestial Level 7', 'Celestial Level 6').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Celestial Level 8', 'Celestial Level 7').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Celestial Level 9', 'Celestial Level 8').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Formal Celestial', 'Celestial Level 9').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Earth Level 1', 'Healing Arts').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Earth Level 2', 'Earth Level 1').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Earth Level 3', 'Earth Level 2').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Earth Level 4', 'Earth Level 3').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Earth Level 5', 'Earth Level 4').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Earth Level 6', 'Earth Level 5').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Earth Level 7', 'Earth Level 6').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Earth Level 8', 'Earth Level 7').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Earth Level 9', 'Earth Level 8').amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    validate_one_pre_req('Formal Earth', 'Earth Level 9').amount.should == 1
  end
  it "can validate Break Command purchase" do
    validate_race_pre_req('Break Command', 'Biata').amount.should == 1
  end
  it "can validate Claws purchase" do
    validate_race_pre_req('Claws', 'Sarr').bought.should == true
  end
  it "can validate Gypsy Curse purchase" do
    validate_race_pre_req('Gypsy Curse', 'Gypsy').amount.should == 1
  end
  it "can validate Racial Assassinate purchase" do
    validate_race_pre_req('Racial Assassinate', 'Sarr').bought.should == true
  end
  it "can validate Racial Dodge purchase" do
    validate_race_pre_req('Racial Dodge', 'Hobling').bought.should == true
  end
  it "can validate Racial Proficiency purchase" do
    validate_race_pre_req('Racial Proficiency', 'High Orc').bought.should == true
  end
  it "can validate Racial Slay purchase" do
    validate_race_pre_req('Racial Slay', 'High Orc').bought.should == true
  end
  it "can validate Resist Binding purchase" do
    validate_race_pre_req('Resist Binding', 'Dryad').amount.should == 1
  end
  it "can validate Resist Command purchase" do
    validate_race_pre_req('Resist Command', 'Elf').amount.should == 1
  end
  it "can validate Resist Element purchase" do
    validate_race_pre_req('Resist Element', 'Dwarf').amount.should == 1
  end
  it "can validate Resist Fear purchase" do
    validate_race_pre_req('Resist Fear', 'Barbarian').amount.should == 1
  end
  it "can validate Resist Magic purchase" do
    validate_race_pre_req('Resist Magic', 'Dark Elf').bought.should == true
  end
  it "can validate Resist Necromancy purchase" do
    validate_race_pre_req('Resist Necromancy', 'High Ogre').amount.should == 1
  end
  it "can validate Resist Poison purchase" do
    validate_race_pre_req('Resist Poison', 'Dwarf').amount.should == 1
  end

end