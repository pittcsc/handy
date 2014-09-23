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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140923200442) do

  create_table "attendances", force: true do |t|
    t.integer "member_id"
    t.integer "event_id"
  end

  create_table "events", force: true do |t|
    t.string  "name"
    t.date    "date"
    t.boolean "current", default: false, null: false
  end

  create_table "members", force: true do |t|
    t.string "name"
    t.string "email"
    t.string "phone", null: false
  end

  add_index "members", ["phone"], name: "index_members_on_phone", using: :btree

end
