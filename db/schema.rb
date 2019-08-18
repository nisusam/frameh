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

ActiveRecord::Schema.define(version: 2019_08_17_103855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "annual_managements", force: :cascade do |t|
    t.integer "year", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["year"], name: "index_annual_managements_on_year", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "country", default: "", null: false
    t.string "city"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "contract_statuses", force: :cascade do |t|
    t.string "key"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_contract_statuses_on_key", unique: true
  end

  create_table "contracts", force: :cascade do |t|
    t.string "name", null: false
    t.string "number"
    t.string "description"
    t.date "start_date", null: false
    t.date "end_date"
    t.bigint "contract_status_id"
    t.bigint "user_group_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_contracts_on_company_id"
    t.index ["contract_status_id"], name: "index_contracts_on_contract_status_id"
    t.index ["user_group_id"], name: "index_contracts_on_user_group_id"
  end

  create_table "expense_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expense_groups", force: :cascade do |t|
    t.integer "expense_value"
    t.bigint "expense_id"
    t.bigint "group_id"
    t.bigint "expense_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_category_id"], name: "index_expense_groups_on_expense_category_id"
    t.index ["expense_id"], name: "index_expense_groups_on_expense_id"
    t.index ["group_id"], name: "index_expense_groups_on_group_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.integer "month"
    t.integer "kind"
    t.bigint "user_group_id"
    t.bigint "annual_management_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["annual_management_id"], name: "index_expenses_on_annual_management_id"
    t.index ["user_group_id"], name: "index_expenses_on_user_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "expense_category_id"
    t.integer "expense_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_category_id"], name: "index_groups_on_expense_category_id"
  end

  create_table "income_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incomes", force: :cascade do |t|
    t.integer "month"
    t.integer "kind"
    t.decimal "income_value"
    t.bigint "user_group_id"
    t.bigint "annual_management_id"
    t.bigint "income_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["annual_management_id"], name: "index_incomes_on_annual_management_id"
    t.index ["income_category_id"], name: "index_incomes_on_income_category_id"
    t.index ["user_group_id"], name: "index_incomes_on_user_group_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.integer "genre"
    t.datetime "birth_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "work_groups", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.bigint "company_id"
    t.bigint "user_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_work_groups_on_company_id"
    t.index ["user_group_id"], name: "index_work_groups_on_user_group_id"
  end

  add_foreign_key "companies", "users"
  add_foreign_key "contacts", "users"
  add_foreign_key "expenses", "annual_managements"
  add_foreign_key "expenses", "user_groups"
  add_foreign_key "groups", "expense_categories"
  add_foreign_key "incomes", "annual_managements"
  add_foreign_key "incomes", "income_categories"
  add_foreign_key "incomes", "user_groups"
  add_foreign_key "user_groups", "users"
  add_foreign_key "work_groups", "companies"
  add_foreign_key "work_groups", "user_groups"
end
