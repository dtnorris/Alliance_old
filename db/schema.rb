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

ActiveRecord::Schema.define(:version => 20120624190918) do

  create_table "character_classes", :force => true do |t|
    t.string   "name"
    t.integer  "build_per_body"
    t.integer  "armor_limit"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "character_skills", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "character_id"
    t.integer  "skill_id"
    t.boolean  "bought"
    t.integer  "amount"
  end

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.integer  "build_points"
    t.integer  "experience_points"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "race_id"
    t.string   "new_skill"
    t.integer  "character_class_id"
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
    t.string   "skill_type"
  end

end
