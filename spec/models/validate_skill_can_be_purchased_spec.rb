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

  it "can validate non-dependant skill purchse" do
    skill = Skill.find_by_name('Blacksmith')
    CharacterSkill.add_skill(char.id, skill.id)
    sk = CharacterSkill.purchase_skill(char.id, skill.id)
    sk.amount.should == 1
  end
  it "can validate Alchemy purchase" do
    skill = Skill.find_by_name('Alchemy')
    skill1 = Skill.find_by_name('Read And Write')
    skill2 = Skill.find_by_name('Herbal Lore')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.add_skill(char.id, skill2.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill2.id)
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Create Potion purchase" do
    skill = Skill.find_by_name('Create Potion')
    skill1 = Skill.find_by_name('Earth Level 1')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Create Scroll purchase" do
    skill = Skill.find_by_name('Create Scroll')
    skill1 = Skill.find_by_name('Celestial Level 1')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Create Trap purchase" do
    skill = Skill.find_by_name('Create Trap')
    skill1 = Skill.find_by_name('Legerdemain')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Herbal Lore purchase" do
    skill = Skill.find_by_name('Herbal Lore')
    skill1 = Skill.find_by_name('Read And Write')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Read Magic purchase" do
    skill = Skill.find_by_name('Read Magic')
    skill1 = Skill.find_by_name('Read And Write')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Healing Arts purchase" do
    skill = Skill.find_by_name('Healing Arts')
    skill1 = Skill.find_by_name('Read And Write')
    skill2 = Skill.find_by_name('First Aid')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.add_skill(char.id, skill2.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill2.id)
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Style Master purchase" do
    skill = Skill.find_by_name('Style Master')
    skill1 = Skill.find_by_name('One Handed Edged')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Back Attack purchase" do
    skill = Skill.find_by_name('Back Attack')
    skill1 = Skill.find_by_name('One Handed Edged')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Critical Attack purchase" do
    skill = Skill.find_by_name('Critical Attack')
    skill1 = Skill.find_by_name('One Handed Edged')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Two Weapons purchase" do
    skill = Skill.find_by_name('Two Weapons')
    skill1 = Skill.find_by_name('Florentine')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill1.id)
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Assassinate purchase" do
    skill = Skill.find_by_name('Assassinate')
    skill1 = Skill.find_by_name('Backstab')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill1.id)
    bs.amount = 2
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Dodge purchase" do
    skill = Skill.find_by_name('Dodge')
    skill1 = Skill.find_by_name('Backstab')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill1.id)
    bs.amount = 2
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Disarm purchase" do
    skill = Skill.find_by_name('Disarm')
    skill1 = Skill.find_by_name('Backstab')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill1.id)
    bs.amount = 1
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Evade purchase" do
    skill = Skill.find_by_name('Evade')
    skill1 = Skill.find_by_name('Backstab')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill1.id)
    bs.amount = 1
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Parry purchase" do
    skill = Skill.find_by_name('Parry')
    skill1 = Skill.find_by_name('Weapon Proficiency')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill1.id)
    bs.amount = 2
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Slay purchase" do
    skill = Skill.find_by_name('Slay')
    skill1 = Skill.find_by_name('Weapon Proficiency')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill1.id)
    bs.amount = 2
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Riposte purchase" do
    skill = Skill.find_by_name('Riposte')
    skill1 = Skill.find_by_name('Weapon Proficiency')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill1.id)
    bs.amount = 4
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Shatter purchase" do
    skill = Skill.find_by_name('Shatter')
    skill1 = Skill.find_by_name('Backstab')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill1.id)
    bs.amount = 3
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Stun Limb purchase" do
    skill = Skill.find_by_name('Stun Limb')
    skill1 = Skill.find_by_name('Weapon Proficiency')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill1.id)
    bs.amount = 3
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Terminate purchase" do
    skill = Skill.find_by_name('Terminate')
    skill1 = Skill.find_by_name('Backstab')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill1.id)
    bs.amount = 4
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
    it "can validate Eviscerate purchase" do
    skill = Skill.find_by_name('Eviscerate')
    skill1 = Skill.find_by_name('Weapon Proficiency')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill1.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill1.id)
    bs.amount = 4
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Backstab purchase" do
    skill = Skill.find_by_name('Backstab')
    skill2 = Skill.find_by_name('Back Attack')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill2.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill2.id)
    bs.amount = 4
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
    CharacterSkill.find_by_character_id_and_skill_id(char.id, skill2.id).amount.should == 0
  end
  it "can validate Weapon Proficiency purchase" do
    skill = Skill.find_by_name('Weapon Proficiency')
    skill2 = Skill.find_by_name('Critical Attack')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    CharacterSkill.add_skill(char.id, skill2.id)
    bs = CharacterSkill.find_by_character_id_and_skill_id(char.id, skill2.id)
    bs.amount = 4
    bs.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
    CharacterSkill.find_by_character_id_and_skill_id(char.id, skill2.id).amount.should == 0
  end
  it "can validate Break Command purchase" do
    skill = Skill.find_by_name('Break Command')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('Biata').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Claws purchase" do
    skill = Skill.find_by_name('Claws')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('Sarr').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Gypsy Curse purchase" do
    skill = Skill.find_by_name('Gypsy Curse')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('Gypsy').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Racial Assassinate purchase" do
    skill = Skill.find_by_name('Racial Assassinate')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('Sarr').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Racial Dodge purchase" do
    skill = Skill.find_by_name('Racial Dodge')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('Hobling').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Racial Proficiency purchase" do
    skill = Skill.find_by_name('Racial Proficiency')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('High Orc').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Racial Slay purchase" do
    skill = Skill.find_by_name('Racial Slay')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('High Orc').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Resist Binding purchase" do
    skill = Skill.find_by_name('Resist Binding')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('Dryad').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Resist Command purchase" do
    skill = Skill.find_by_name('Resist Command')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('Elf').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Resist Element purchase" do
    skill = Skill.find_by_name('Resist Element')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('Dwarf').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Resist Fear purchase" do
    skill = Skill.find_by_name('Resist Fear')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('Barbarian').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Resist Magic purchase" do
    skill = Skill.find_by_name('Resist Magic')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('Dark Elf').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).bought.should == true
  end
  it "can validate Resist Necromancy purchase" do
    skill = Skill.find_by_name('Resist Necromancy')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('High Ogre').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end
  it "can validate Resist Poison purchase" do
    skill = Skill.find_by_name('Resist Poison')
    CharacterSkill.add_skill(char.id, skill.id)
    CharacterSkill.purchase_skill(char.id, skill.id).should == "Pre-requisites are not met to purchase this skill"
    char.race_id = Race.find_by_name('Dwarf').id
    char.save
    CharacterSkill.purchase_skill(char.id, skill.id).amount.should == 1
  end

end