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

ActiveRecord::Schema.define(:version => 20120816215759) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.integer  "chapter_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attendees", :force => true do |t|
    t.integer  "character_id"
    t.integer  "event_id"
    t.boolean  "applied",      :default => false
    t.boolean  "pc"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "chapters", :force => true do |t|
    t.string   "owner"
    t.string   "email"
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "char_classes", :force => true do |t|
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
    t.integer  "user_id"
    t.integer  "home_chapter"
    t.integer  "race_id"
    t.integer  "char_class_id"
    t.integer  "experience_points"
    t.integer  "build_points"
    t.integer  "spent_build"
    t.integer  "new_skill"
    t.integer  "buy_skill"
    t.integer  "body_points"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "deaths", :force => true do |t|
    t.integer  "character_id"
    t.integer  "chapter_id"
    t.boolean  "regen_css",    :default => false
    t.boolean  "buyback",      :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.float    "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "chapter_id"
    t.integer  "event_type_id"
    t.date     "date"
    t.string   "name"
    t.boolean  "applied"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "members", :force => true do |t|
    t.integer  "chapter_id"
    t.integer  "user_id"
    t.integer  "goblin_stamps"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "character_id"
    t.boolean  "blanket_list"
  end

  create_table "races", :force => true do |t|
    t.string   "name"
    t.integer  "body_mod"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.string   "skill_type"
    t.string   "group"
    t.integer  "fighter"
    t.integer  "scout"
    t.integer  "rogue"
    t.integer  "adept"
    t.integer  "scholar"
    t.integer  "templar"
    t.integer  "artisan"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stamp_tracks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "chapter_id"
    t.integer  "start_stamps"
    t.integer  "end_stamps"
    t.string   "reason"
    t.boolean  "dragon_stamps"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "dragon_stamps"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "xp_tracks", :force => true do |t|
    t.integer  "attendee_id"
    t.integer  "start_xp"
    t.integer  "end_xp"
    t.integer  "start_build"
    t.integer  "end_build"
    t.string   "reason"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
