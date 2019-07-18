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

ActiveRecord::Schema.define(version: 2019_07_18_194704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.bigint "expense_id"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "invoice_equivalent_id"
    t.index ["expense_id"], name: "index_attachments_on_expense_id"
    t.index ["invoice_equivalent_id"], name: "index_attachments_on_invoice_equivalent_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tax_id"
    t.string "address"
    t.string "email"
    t.string "cell_phone"
    t.string "logo"
    t.string "signature"
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "concepts", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.decimal "vat", precision: 15, scale: 10
    t.integer "amount_cents", default: 0, null: false
    t.bigint "expense_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_concepts_on_expense_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.integer "tax_id_type"
    t.string "tax_id"
    t.boolean "provider", default: false
    t.boolean "client", default: false
    t.string "phone"
    t.string "cell_phone"
    t.string "province"
    t.string "city"
    t.string "address"
    t.string "email"
    t.bigint "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_number"
    t.integer "account_type"
    t.integer "account_bank"
    t.index ["business_id"], name: "index_contacts_on_business_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.date "date"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "amount_cents", default: 0, null: false
    t.bigint "business_id"
    t.integer "payment_method"
    t.text "observation"
    t.bigint "number"
    t.bigint "contact_id"
    t.index ["business_id"], name: "index_expenses_on_business_id"
    t.index ["contact_id"], name: "index_expenses_on_contact_id"
  end

  create_table "invoice_equivalents", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "contact_id"
    t.date "date"
    t.bigint "number"
    t.text "observation"
    t.integer "retention_type"
    t.string "description"
    t.bigint "amount_cents", default: 0, null: false
    t.bigint "retention_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_invoice_equivalents_on_business_id"
    t.index ["contact_id"], name: "index_invoice_equivalents_on_contact_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "number"
    t.bigint "contact_id"
    t.date "date"
    t.string "signature"
    t.text "terms_and_conditions"
    t.text "notes"
    t.text "resolution_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "business_id"
    t.date "expiration_date"
    t.index ["business_id"], name: "index_invoices_on_business_id"
    t.index ["contact_id"], name: "index_invoices_on_contact_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.bigint "price_cents", default: 0, null: false
    t.decimal "vat", precision: 15, scale: 10
    t.decimal "discount", precision: 15, scale: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invoice_id"
    t.index ["invoice_id"], name: "index_items_on_invoice_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "invoice_id"
    t.bigint "number"
    t.date "date"
    t.integer "payment_method"
    t.string "description"
    t.bigint "amount_cents", default: 0, null: false
    t.bigint "retention_cents", default: 0, null: false
    t.text "observation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "business_id"
    t.integer "retention_type"
    t.index ["business_id"], name: "index_payments_on_business_id"
    t.index ["contact_id"], name: "index_payments_on_contact_id"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
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
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.datetime "token_expiry"
    t.string "google_picture_url"
    t.string "first_name"
    t.string "last_name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attachments", "expenses"
  add_foreign_key "attachments", "invoice_equivalents"
  add_foreign_key "businesses", "users"
  add_foreign_key "concepts", "expenses"
  add_foreign_key "contacts", "businesses"
  add_foreign_key "expenses", "businesses"
  add_foreign_key "expenses", "contacts"
  add_foreign_key "invoice_equivalents", "businesses"
  add_foreign_key "invoice_equivalents", "contacts"
  add_foreign_key "invoices", "businesses"
  add_foreign_key "invoices", "contacts"
  add_foreign_key "items", "invoices"
  add_foreign_key "payments", "businesses"
  add_foreign_key "payments", "contacts"
  add_foreign_key "payments", "invoices"
end
