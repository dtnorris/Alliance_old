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

ActiveRecord::Schema.define(:version => 20120706012811) do

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

  create_table "races", :force => true do |t|
    t.string   "name"
    t.integer  "body_mod"
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
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "xp_tracks", :force => true do |t|
    t.integer  "character_id"
    t.integer  "start_xp"
    t.integer  "end_xp"
    t.integer  "start_build"
    t.integer  "end_build"
    t.string   "reason"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
