# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Race.create(name: 'Barbarian', body_mod: 2)
Race.create(name: 'Biata', body_mod: 0)
Race.create(name: 'Dark Elf', body_mod: -1)
Race.create(name: 'Dryad', body_mod: 0)
Race.create(name: 'Dwarf', body_mod: 1)
Race.create(name: 'Elf', body_mod: -1)
Race.create(name: 'Gypsy', body_mod: 0)
Race.create(name: 'High Ogre', body_mod: 2)
Race.create(name: 'High Orc', body_mod: 2)
Race.create(name: 'Hobling', body_mod: -1)
Race.create(name: 'Human', body_mod: 0)
Race.create(name: 'Mystic Wood Elf', body_mod: -1)
Race.create(name: 'Sarr', body_mod: 0)
Race.create(name: 'Stone Elf', body_mod: -1)
Race.create(name: 'Wylderkin', body_mod: 0)

CharClass.create(name: 'Fighter', armor_limit: 35, build_per_body: 5)
CharClass.create(name: 'Scout', armor_limit: 30, build_per_body: 7)
CharClass.create(name: 'Rogue', armor_limit: 25, build_per_body: 8)
CharClass.create(name: 'Templar', armor_limit: 25, build_per_body: 9)
CharClass.create(name: 'Adept', armor_limit: 20, build_per_body: 10)
CharClass.create(name: 'Artisan', armor_limit: 20, build_per_body: 12)
CharClass.create(name: 'Scholar', armor_limit: 15, build_per_body: 15)

Skill.create(name: 'Alchemy', fighter: 6, scout: 5, rogue: 3, adept: 4, scholar: 4, templar: 6, artisan: 3, skill_type: 'int', group: 'other')
Skill.create(name: 'Blacksmith', fighter: 3, scout: 3, rogue: 4, adept: 4, scholar: 4, templar: 3, artisan: 3, skill_type: 'int', group: 'other')
Skill.create(name: 'Create Potion', fighter: 6, scout: 6, rogue: 6, adept: 4, scholar: 3, templar: 4, artisan: 3, skill_type: 'int', group: 'other')
Skill.create(name: 'Create Scroll', fighter: 6, scout: 6, rogue: 6, adept: 4, scholar: 3, templar: 4, artisan: 3, skill_type: 'int', group: 'other')
Skill.create(name: 'Create Trap', fighter: 6, scout: 4, rogue: 3, adept: 4, scholar: 6, templar: 6, artisan: 3, skill_type: 'int', group: 'other')
Skill.create(name: 'Herbal Lore', fighter: 6, scout: 5, rogue: 3, adept: 4, scholar: 4, templar: 6, artisan: 3, skill_type: 'bol', group: 'other')
Skill.create(name: 'Legerdemain', fighter: 10, scout: 8, rogue: 4, adept: 8, scholar: 10, templar: 10, artisan: 8, skill_type: 'bol', group: 'other')
Skill.create(name: 'Merchant', fighter: 3, scout: 2, rogue: 1, adept: 2, scholar: 3, templar: 3, artisan: 1, skill_type: 'bol', group: 'other')
Skill.create(name: 'Teacher', fighter: 1, scout: 1, rogue: 1, adept: 1, scholar: 1, templar: 1, artisan: 1, skill_type: 'int', group: 'other')
Skill.create(name: 'Wear Extra Armor', fighter: 1, scout: 1, rogue: 1, adept: 1, scholar: 1, templar: 1, artisan: 1, skill_type: 'int', group: 'other')
Skill.create(name: 'Craftsman', fighter: 2, scout: 2, rogue: 2, adept: 2, scholar: 2, templar: 2, artisan: 2, skill_type: 'int', group: 'other')

Skill.create(name: 'Break Command', fighter: 2, scout: 2, rogue: 2, adept: 2, scholar: 2, templar: 2, artisan: 2, skill_type: 'int', group: 'race')
Skill.create(name: 'Claws', fighter: 8, scout: 8, rogue: 8, adept: 8, scholar: 8, templar: 8, artisan: 8, skill_type: 'bol', group: 'race')
Skill.create(name: 'Gypsy Curse', fighter: 2, scout: 2, rogue: 2, adept: 2, scholar: 2, templar: 2, artisan: 2, skill_type: 'int', group: 'race')
Skill.create(name: 'Racial Assassinate', fighter: 4, scout: 4, rogue: 4, adept: 4, scholar: 4, templar: 4, artisan: 4, skill_type: 'bol', group: 'race')
Skill.create(name: 'Racial Dodge', fighter: 10, scout: 10, rogue: 10, adept: 10, scholar: 10, templar: 10, artisan: 10, skill_type: 'bol', group: 'race')
Skill.create(name: 'Racial Proficiency', fighter: 10, scout: 10, rogue: 10, adept: 10, scholar: 10, templar: 10, artisan: 10, skill_type: 'bol', group: 'race')
Skill.create(name: 'Racial Slay', fighter: 6, scout: 6, rogue: 6, adept: 6, scholar: 6, templar: 6, artisan: 6, skill_type: 'bol', group: 'race')
Skill.create(name: 'Resist Binding', fighter: 4, scout: 4, rogue: 4, adept: 4, scholar: 4, templar: 4, artisan: 4, skill_type: 'int', group: 'race')
Skill.create(name: 'Resist Command', fighter: 4, scout: 4, rogue: 4, adept: 4, scholar: 4, templar: 4, artisan: 4, skill_type: 'int', group: 'race')
Skill.create(name: 'Resist Element', fighter: 3, scout: 3, rogue: 3, adept: 3, scholar: 3, templar: 3, artisan: 3, skill_type: 'int', group: 'race')
Skill.create(name: 'Resist Fear', fighter: 2, scout: 2, rogue: 2, adept: 2, scholar: 2, templar: 2, artisan: 2, skill_type: 'int', group: 'race')
Skill.create(name: 'Resist Magic', fighter: 5, scout: 5, rogue: 5, adept: 5, scholar: 5, templar: 5, artisan: 5, skill_type: 'bol', group: 'race')
Skill.create(name: 'Resist Necromancy', fighter: 4, scout: 4, rogue: 4, adept: 4, scholar: 4, templar: 4, artisan: 4, skill_type: 'int', group: 'race')
Skill.create(name: 'Resist Poison', fighter: 4, scout: 4, rogue: 4, adept: 4, scholar: 4, templar: 4, artisan: 4, skill_type: 'int', group: 'race')

Skill.create(name: 'Archery', fighter: 6, scout: 6, rogue: 6, adept: 8, scholar: 12, templar: 8, artisan: 8, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Florentine', fighter: 4, scout: 6, rogue: 6, adept: 6, scholar: 8, templar: 6, artisan: 6, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'One Handed Blunt', fighter: 3, scout: 4, rogue: 4, adept: 5, scholar: 6, templar: 5, artisan: 5, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'One Handed Edged', fighter: 5, scout: 5, rogue: 5, adept: 7, scholar: 10, templar: 7, artisan: 7, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'One Handed Master', fighter: 7, scout: 8, rogue: 8, adept: 10, scholar: 14, templar: 10, artisan: 10, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Polearm', fighter: 8, scout: 12, rogue: 12, adept: 12, scholar: 16, templar: 12, artisan: 12, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Shield', fighter: 6, scout: 10, rogue: 10, adept: 10, scholar: 12, templar: 10, artisan: 10, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Small Weapon', fighter: 2, scout: 2, rogue: 2, adept: 2, scholar: 2, templar: 2, artisan: 2, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Staff', fighter: 4, scout: 4, rogue: 4, adept: 4, scholar: 4, templar: 4, artisan: 4, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Style Master', fighter: 10, scout: 15, rogue: 15, adept: 15, scholar: 20, templar: 15, artisan: 15, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Thrown Weapon', fighter: 2, scout: 4, rogue: 4, adept: 4, scholar: 4, templar: 4, artisan: 4, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Two Handed Blunt', fighter: 6, scout: 8, rogue: 8, adept: 8, scholar: 12, templar: 8, artisan: 8, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Two Handed Sword', fighter: 8, scout: 12, rogue: 12, adept: 12, scholar: 16, templar: 12, artisan: 12, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Two Handed Master', fighter: 10, scout: 16, rogue: 16, adept: 16, scholar: 20, templar: 16, artisan: 16, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Two Weapons', fighter: 2, scout: 4, rogue: 4, adept: 4, scholar: 4, templar: 4, artisan: 4, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Weapon Master', fighter: 15, scout: 20, rogue: 20, adept: 20, scholar: 25, templar: 20, artisan: 20, skill_type: 'bol', group: 'weapon')
Skill.create(name: 'Waylay', fighter: 12, scout: 8, rogue: 6, adept: 8, scholar: 12, templar: 12, artisan: 12, skill_type: 'bol', group: 'weapon')

Skill.create(name: 'Assassinate', fighter: 8, scout: 3, rogue: 3, adept: 4, scholar: 8, templar: 8, artisan: 8, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Back Attack', fighter: 6, scout: 3, rogue: 3, adept: 3, scholar: 8, templar: 6, artisan: 6, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Backstab', fighter: 30, scout: 18, rogue: 15, adept: 18, scholar: 40, templar: 30, artisan: 30, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Critical Attack', fighter: 3, scout: 3, rogue: 5, adept: 6, scholar: 8, templar: 3, artisan: 8, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Disarm', fighter: 2, scout: 2, rogue: 2, adept: 3, scholar: 8, templar: 3, artisan: 8, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Dodge', fighter: 8, scout: 6, rogue: 5, adept: 6, scholar: 8, templar: 8, artisan: 8, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Evade', fighter: 8, scout: 3, rogue: 3, adept: 4, scholar: 8, templar: 8, artisan: 8, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Eviscerate', fighter: 5, scout: 7, rogue: 14, adept: 14, scholar: 14, templar: 7, artisan: 14, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Parry', fighter: 4, scout: 4, rogue: 8, adept: 8, scholar: 8, templar: 5, artisan: 8, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Riposte', fighter: 5, scout: 5, rogue: 5, adept: 6, scholar: 8, templar: 6, artisan: 8, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Shatter', fighter: 3, scout: 3, rogue: 3, adept: 4, scholar: 8, templar: 4, artisan: 8, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Slay', fighter: 4, scout: 4, rogue: 8, adept: 8, scholar: 8, templar: 5, artisan: 8, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Stun Limb', fighter: 3, scout: 3, rogue: 3, adept: 4, scholar: 8, templar: 4, artisan: 8, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Terminate', fighter: 12, scout: 6, rogue: 4, adept: 6, scholar: 12, templar: 12, artisan: 12, skill_type: 'int', group: 'specialty')
Skill.create(name: 'Weapon Proficiency', fighter: 15, scout: 18, rogue: 26, adept: 30, scholar: 40, templar: 18, artisan: 30, skill_type: 'int', group: 'specialty')

Skill.create(name: 'Read And Write', fighter: 6, scout: 6, rogue: 6, adept: 3, scholar: 3, templar: 3, artisan: 3, skill_type: 'bol', group: 'spells')
Skill.create(name: 'Read Magic', fighter: 8, scout: 8, rogue: 6, adept: 4, scholar: 4, templar: 4, artisan: 6, skill_type: 'bol', group: 'spells')
Skill.create(name: 'First Aid', fighter: 2, scout: 2, rogue: 2, adept: 2, scholar: 2, templar: 2, artisan: 2, skill_type: 'bol', group: 'spells')
Skill.create(name: 'Healing Arts', fighter: 6, scout: 6, rogue: 4, adept: 2, scholar: 2, templar: 2, artisan: 4, skill_type: 'bol', group: 'spells')
Skill.create(name: 'Celestial Level 1', fighter: 3, scout: 3, rogue: 2, adept: 1, scholar: 1, templar: 1, artisan: 1, skill_type: 'int', group: 'spells')
Skill.create(name: 'Celestial Level 2', fighter: 3, scout: 3, rogue: 2, adept: 1, scholar: 1, templar: 1, artisan: 2, skill_type: 'int', group: 'spells')
Skill.create(name: 'Celestial Level 3', fighter: 6, scout: 6, rogue: 4, adept: 2, scholar: 2, templar: 2, artisan: 2, skill_type: 'int', group: 'spells')
Skill.create(name: 'Celestial Level 4', fighter: 6, scout: 6, rogue: 4, adept: 3, scholar: 2, templar: 3, artisan: 3, skill_type: 'int', group: 'spells')
Skill.create(name: 'Celestial Level 5', fighter: 9, scout: 9, rogue: 6, adept: 3, scholar: 3, templar: 3, artisan: 4, skill_type: 'int', group: 'spells')
Skill.create(name: 'Celestial Level 6', fighter: 9, scout: 9, rogue: 6, adept: 4, scholar: 3, templar: 4, artisan: 4, skill_type: 'int', group: 'spells')
Skill.create(name: 'Celestial Level 7', fighter: 12, scout: 12, rogue: 8, adept: 5, scholar: 4, templar: 5, artisan: 5, skill_type: 'int', group: 'spells')
Skill.create(name: 'Celestial Level 8', fighter: 12, scout: 12, rogue: 8, adept: 5, scholar: 4, templar: 5, artisan: 6, skill_type: 'int', group: 'spells')
Skill.create(name: 'Celestial Level 9', fighter: 15, scout: 15, rogue: 10, adept: 6, scholar: 5, templar: 6, artisan: 6, skill_type: 'int', group: 'spells')
Skill.create(name: 'Formal Celestial', fighter: 12, scout: 12, rogue: 8, adept: 4, scholar: 3, templar: 4, artisan: 4, skill_type: 'int', group: 'spells')
Skill.create(name: 'Earth Level 1', fighter: 3, scout: 3, rogue: 2, adept: 1, scholar: 1, templar: 1, artisan: 1, skill_type: 'int', group: 'spells')
Skill.create(name: 'Earth Level 2', fighter: 3, scout: 3, rogue: 2, adept: 1, scholar: 1, templar: 1, artisan: 2, skill_type: 'int', group: 'spells')
Skill.create(name: 'Earth Level 3', fighter: 6, scout: 6, rogue: 4, adept: 2, scholar: 2, templar: 2, artisan: 2, skill_type: 'int', group: 'spells')
Skill.create(name: 'Earth Level 4', fighter: 6, scout: 6, rogue: 4, adept: 3, scholar: 2, templar: 3, artisan: 3, skill_type: 'int', group: 'spells')
Skill.create(name: 'Earth Level 5', fighter: 9, scout: 9, rogue: 6, adept: 3, scholar: 3, templar: 3, artisan: 4, skill_type: 'int', group: 'spells')
Skill.create(name: 'Earth Level 6', fighter: 9, scout: 9, rogue: 6, adept: 4, scholar: 3, templar: 4, artisan: 4, skill_type: 'int', group: 'spells')
Skill.create(name: 'Earth Level 7', fighter: 12, scout: 12, rogue: 8, adept: 5, scholar: 4, templar: 5, artisan: 5, skill_type: 'int', group: 'spells')
Skill.create(name: 'Earth Level 8', fighter: 12, scout: 12, rogue: 8, adept: 5, scholar: 4, templar: 5, artisan: 6, skill_type: 'int', group: 'spells')
Skill.create(name: 'Earth Level 9', fighter: 15, scout: 15, rogue: 10, adept: 6, scholar: 5, templar: 6, artisan: 6, skill_type: 'int', group: 'spells')
Skill.create(name: 'Formal Earth', fighter: 12, scout: 12, rogue: 8, adept: 4, scholar: 3, templar: 4, artisan: 4, skill_type: 'int', group: 'spells')

Chapter.create(name: 'Caldaria', owner: 'Jessie Hennessey', email: 'gm@caldaria.com', location: "CT")
User.create(email: 'dreamingfurther@test.com', first_name: 'Dreaming', last_name: 'Further', password: 'txt@1234', dragon_stamps: 0)
Member.create(user_id: 1, chapter_id:1, goblin_stamps: 0)


# Seed some basic users and characters for development
if Rails.env != 'test'
  Chapter.create(name: 'Gaden', owner: 'Dave Glaiser', email: 'djglaeser@gmail.com', location: "SoMN")

  User.create(email: 'alliance_admin@test.com', first_name: 'Alliance', last_name: 'Admin', password: 'txt@1234', dragon_stamps: 0)
  User.create(email: 'chapter_admin@test.com', first_name: 'Chapter', last_name: 'Admin', password: 'txt@1234', dragon_stamps: 0)
  User.create(email: 'alliance_player@test.com', first_name: 'Alliance', last_name: 'Player', password: 'txt@1234', dragon_stamps: 0)

  Member.create(user_id: 1, chapter_id:2, goblin_stamps: 0)
  Member.create(user_id: 4, chapter_id:1, goblin_stamps: 0)

  Character.create(name: 'Bob', user_id: 1, race_id: 1, char_class_id: 1, build_points: 15, spent_build: 0, experience_points: 0, home_chapter: 1)
  Character.create(name: 'Hannah', user_id: 1, race_id: 6, char_class_id: 7, build_points: 15, spent_build: 0, experience_points: 0, home_chapter: 2)
  Character.create(name: 'Joe', user_id: 4, race_id: 11, char_class_id: 4, build_points: 15, spent_build: 0, experience_points: 0, home_chapter: 1)
end