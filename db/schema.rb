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

ActiveRecord::Schema.define(version: 20160108135457) do

  create_table "candidates", force: :cascade do |t|
    t.string "name",        limit: 255,   null: false
    t.text   "description", limit: 65535, null: false
    t.string "image",       limit: 255,   null: false
  end

  create_table "votes", force: :cascade do |t|
    t.string   "name",         limit: 255, null: false
    t.string   "subject",      limit: 255, null: false
    t.integer  "ammount",      limit: 4,   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "ip",           limit: 8
    t.integer  "candidate_id", limit: 4
  end

  add_index "votes", ["candidate_id"], name: "index_votes_on_candidate_id", using: :btree
  add_index "votes", ["name"], name: "index_votes_on_name", using: :btree
  add_index "votes", ["subject"], name: "index_votes_on_subject", using: :btree

end
