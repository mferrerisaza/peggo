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

ActiveRecord::Schema.define(version: 2018_08_29_012722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.bigint "share_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["share_id"], name: "index_bills_on_share_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.bigint "building_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "amount_cents", default: 0, null: false
    t.boolean "status", default: false, null: false
    t.index ["building_id"], name: "index_budgets_on_building_id"
  end

  create_table "buildings", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_buildings_on_user_id"
  end

  create_table "concepts", force: :cascade do |t|
    t.bigint "bill_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.index ["bill_id"], name: "index_concepts_on_bill_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.integer "category"
    t.date "date"
    t.bigint "budget_id"
    t.string "description"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.index ["budget_id"], name: "index_expenses_on_budget_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.string "card_number"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "building_id"
    t.index ["building_id"], name: "index_owners_on_building_id"
    t.index ["user_id"], name: "index_owners_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.integer "property_type"
    t.string "name"
    t.string "phone"
    t.string "matricula_inmobiliaria"
    t.decimal "building_coeficient", precision: 15, scale: 2
    t.bigint "building_id"
    t.integer "area"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_properties_on_building_id"
  end

  create_table "shares", force: :cascade do |t|
    t.bigint "property_id"
    t.bigint "owner_id"
    t.decimal "ownerability_percentage", precision: 15, scale: 2
    t.decimal "payment_percentage", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_shares_on_owner_id"
    t.index ["property_id"], name: "index_shares_on_property_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bills", "shares"
  add_foreign_key "budgets", "buildings"
  add_foreign_key "buildings", "users"
  add_foreign_key "concepts", "bills"
  add_foreign_key "expenses", "budgets"
  add_foreign_key "owners", "buildings"
  add_foreign_key "owners", "users"
  add_foreign_key "properties", "buildings"
  add_foreign_key "shares", "owners"
  add_foreign_key "shares", "properties"
end
