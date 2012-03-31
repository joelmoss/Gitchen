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

ActiveRecord::Schema.define(:version => 20120329205221) do

  create_table "repos", :force => true do |t|
    t.string   "name"
    t.string   "language"
    t.text     "description"
    t.boolean  "fork"
    t.boolean  "private"
    t.integer  "watchers_count", :default => 0
    t.integer  "size",           :default => 0
    t.integer  "forks",          :default => 0
    t.integer  "open_issues",    :default => 0
    t.integer  "owner_id"
    t.datetime "pushed_at"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "github_access_token"
    t.text     "github_data"
    t.integer  "watchings_count",     :default => 0
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "watches", :force => true do |t|
    t.integer  "user_id"
    t.integer  "repo_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
