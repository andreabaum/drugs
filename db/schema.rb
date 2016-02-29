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

ActiveRecord::Schema.define(version: 20160229103910) do

  create_table "consumptions", force: :cascade do |t|
    t.integer  "drug_id"
    t.time     "when"
    t.float    "amount"
    t.text     "note"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.date     "starts_at",  default: '2016-02-29'
    t.date     "ends_at",    default: '2016-02-29'
  end

  add_index "consumptions", ["drug_id"], name: "index_consumptions_on_drug_id"

  create_table "drugs", force: :cascade do |t|
    t.string   "name"
    t.text     "note"
    t.boolean  "active"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.float    "reset_amount"
    t.date     "reset_at"
    t.string   "format"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "drug_id"
    t.date     "when"
    t.text     "note"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "purchases", ["drug_id"], name: "index_purchases_on_drug_id"

end
