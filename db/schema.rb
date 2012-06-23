# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120623205957) do

  create_table "character_skills", :force => true do |t|
    t.boolean  "alchemy"
    t.integer  "blacksmith"
    t.integer  "create_potion"
    t.integer  "create_scroll"
    t.integer  "create_trap"
    t.boolean  "herbal_lore"
    t.boolean  "legerdemain"
    t.boolean  "merchant"
    t.integer  "teacher"
    t.integer  "wear_extra_armor"
    t.integer  "break_command"
    t.boolean  "claws"
    t.integer  "gypsy_curse"
    t.boolean  "racial_assassinate"
    t.boolean  "racial_dodge"
    t.boolean  "racial_proficiency"
    t.boolean  "racial_slay"
    t.integer  "resist_binding"
    t.integer  "resist_command"
    t.integer  "resist_element"
    t.integer  "resist_fear"
    t.boolean  "resist_magic"
    t.integer  "resist_necromancy"
    t.integer  "resist_poison"
    t.boolean  "archery"
    t.boolean  "florentine"
    t.boolean  "one_handed_blunt"
    t.boolean  "one_handed_edged"
    t.boolean  "one_handed_master"
    t.boolean  "polearm"
    t.boolean  "small_weapon"
    t.boolean  "staff"
    t.boolean  "style_master"
    t.boolean  "thrown_weapon"
    t.boolean  "two_handed_blunt"
    t.boolean  "two_handed_sword"
    t.boolean  "two_handed_master"
    t.boolean  "two_weapons"
    t.boolean  "weapon_master"
    t.integer  "assassinate"
    t.integer  "back_attack"
    t.integer  "backstab"
    t.integer  "critical_attack"
    t.integer  "disarm"
    t.integer  "dodge"
    t.integer  "evade"
    t.integer  "eviscerate"
    t.integer  "parry"
    t.integer  "riposte"
    t.integer  "shatter"
    t.boolean  "shield"
    t.integer  "slay"
    t.integer  "stun_limb"
    t.integer  "terminate"
    t.boolean  "waylay"
    t.integer  "weapon_proficiency"
    t.boolean  "read_and_write"
    t.boolean  "read_magic"
    t.boolean  "first_aid"
    t.boolean  "healing_arts"
    t.integer  "celestial_level_1"
    t.integer  "celestial_level_2"
    t.integer  "celestial_level_3"
    t.integer  "celestial_level_4"
    t.integer  "celestial_level_5"
    t.integer  "celestial_level_6"
    t.integer  "celestial_level_7"
    t.integer  "celestial_level_8"
    t.integer  "celestial_level_9"
    t.integer  "formal_celestial"
    t.integer  "earth_level_1"
    t.integer  "earth_level_2"
    t.integer  "earth_level_3"
    t.integer  "earth_level_4"
    t.integer  "earth_level_5"
    t.integer  "earth_level_6"
    t.integer  "earth_level_7"
    t.integer  "earth_level_8"
    t.integer  "earth_level_9"
    t.integer  "formal_earth"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.integer  "build_points"
    t.integer  "experience_points"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "race_id"
    t.integer  "character_skill_id"
  end

  create_table "races", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.integer  "fighter_cost"
    t.integer  "scout_cost"
    t.integer  "rogue_cost"
    t.integer  "adept_cost"
    t.integer  "scholar_cost"
    t.integer  "templar_cost"
    t.integer  "artisan_cost"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
