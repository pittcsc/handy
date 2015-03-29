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

ActiveRecord::Schema.define(version: 20150329015656) do

  create_table "accesses", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "organization_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "accesses", ["user_id", "organization_id"], name: "index_accesses_on_user_id_and_organization_id", unique: true, using: :btree

  create_table "attendances", force: :cascade do |t|
    t.integer  "member_id",  limit: 4
    t.integer  "event_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "attendances", ["event_id", "member_id"], name: "index_attendances_on_event_id_and_member_id", unique: true, using: :btree

  create_table "event_ownerships", force: :cascade do |t|
    t.integer  "event_id",        limit: 4
    t.integer  "organization_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "event_ownerships", ["event_id", "organization_id"], name: "index_event_ownerships_on_event_id_and_organization_id", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.date     "date"
    t.boolean  "active",     limit: 1,   default: false, null: false
    t.string   "token",      limit: 255,                 null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "events", ["token"], name: "index_events_on_token", unique: true, using: :btree

  create_table "members", force: :cascade do |t|
    t.string "name",  limit: 255
    t.string "email", limit: 255
    t.string "phone", limit: 255, null: false
  end

  add_index "members", ["phone"], name: "index_members_on_phone", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "event_id",      limit: 4,   null: false
    t.string   "phone_number",  limit: 255, null: false
    t.string   "name",          limit: 255
    t.string   "email_address", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "registrations", ["event_id"], name: "index_registrations_on_event_id", using: :btree
  add_index "registrations", ["phone_number"], name: "index_registrations_on_phone_number", using: :btree

  create_table "text_messages", force: :cascade do |t|
    t.string   "phone_number", limit: 255, null: false
    t.string   "body",         limit: 255, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "direction",    limit: 4,   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255,                 null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "password_digest", limit: 255,                 null: false
    t.boolean  "admin",           limit: 1,   default: false, null: false
  end

  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
