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

ActiveRecord::Schema.define(version: 20150301005945) do

  create_table "commitments", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "expiry_date"
    t.string   "status"
    t.float    "cost"
    t.string   "account_id"
    t.string   "beneficiary"
    t.string   "beneficiary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsorships", force: true do |t|
    t.float    "cost",             default: 0.0, null: false
    t.integer  "user_id"
    t.integer  "commitment_id"
    t.string   "sponsorship_type", default: "",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorships", ["commitment_id"], name: "index_sponsorships_on_commitment_id"
  add_index "sponsorships", ["user_id", "commitment_id", "sponsorship_type"], name: "unique_sponsorships", unique: true
  add_index "sponsorships", ["user_id"], name: "index_sponsorships_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                   null: false
    t.string   "first_name", default: ""
    t.string   "last_name",  default: ""
    t.string   "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
