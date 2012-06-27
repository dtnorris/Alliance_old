require 'spec_helper'

describe CharacterSkill do
  it "can add_or_update_skill" do
    char = Character.create
    skill_alch = Skill.find(1)
    skill_herb = Skill.find(6)
    CharacterSkill.all.count == 0
    CharacterSkill.add_or_update_skill(char.id, skill_alch.id)
    CharacterSkill.all.count == 1
    CharacterSkill.add_or_update_skill(char.id, skill_alch.id)
    CharacterSkill.all.count == 1
    CharacterSkill.add_or_update_skill(char.id, skill_herb.id)
    CharacterSkill.all.count == 2
    CharacterSkill.add_or_update_skill(char.id, skill_herb.id)
    CharacterSkill.all.count == 2
  end
end
