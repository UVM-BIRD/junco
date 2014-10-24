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

ActiveRecord::Schema.define(version: 20141024184229) do

  create_table "journal_continuation_maps", id: false, force: true do |t|
    t.integer "source_journal_id", null: false
    t.integer "verb_id",           null: false
    t.integer "target_journal_id", null: false
  end

  add_index "journal_continuation_maps", ["source_journal_id", "target_journal_id"], name: "source_target_index", unique: true, using: :btree
  add_index "journal_continuation_maps", ["source_journal_id"], name: "index_journal_continuation_maps_on_source_journal_id", using: :btree
  add_index "journal_continuation_maps", ["target_journal_id"], name: "index_journal_continuation_maps_on_target_journal_id", using: :btree

  create_table "journals", force: true do |t|
    t.boolean  "preferred",               null: false
    t.string   "nlm_id",      limit: 50,  null: false
    t.string   "abbrv",       limit: 250, null: false
    t.string   "full",        limit: 500, null: false
    t.string   "issn_print",  limit: 50
    t.string   "issn_online", limit: 50
    t.integer  "start_year"
    t.integer  "end_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "verbs", force: true do |t|
    t.string   "name",       limit: 50,  null: false
    t.string   "rdaw_id",    limit: 10,  null: false
    t.string   "desc",       limit: 250, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
