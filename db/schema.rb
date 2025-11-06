# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_11_06_104924) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "addressable_id", null: false
    t.string "addressable_type", null: false
    t.string "building"
    t.string "city"
    t.integer "country"
    t.datetime "created_at", null: false
    t.string "postal_code"
    t.string "prefecture"
    t.string "street"
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string "account_holder"
    t.string "account_number"
    t.integer "account_type", default: 0, null: false
    t.bigint "accountable_id", null: false
    t.string "accountable_type", null: false
    t.string "bank_name"
    t.string "branch_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accountable_type", "accountable_id"], name: "index_bank_accounts_on_accountable"
  end

  create_table "clients", force: :cascade do |t|
    t.integer "calculation_mode", default: 0, null: false
    t.datetime "created_at", null: false
    t.integer "hourly_rate_cents", default: 0, null: false
    t.string "hourly_rate_currency", default: "JPY", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
  end

  create_table "contract_instances", force: :cascade do |t|
    t.integer "budget_limit_cents"
    t.string "budget_limit_currency"
    t.bigint "contract_id", null: false
    t.datetime "created_at", null: false
    t.date "end_date"
    t.date "start_date"
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_contract_instances_on_contract_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "budget_limit_cents"
    t.string "budget_limit_currency", default: "JPY"
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.boolean "process_time_entries", default: false, null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["client_id"], name: "index_contracts_on_client_id"
    t.index ["name"], name: "index_contracts_on_name", unique: true
  end

  create_table "cost_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["name"], name: "index_cost_types_on_name", unique: true
  end

  create_table "expenses", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "JPY", null: false
    t.bigint "contract_instance_id"
    t.bigint "cost_type_id", null: false
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.text "description"
    t.bigint "invoice_id"
    t.integer "transaction_type", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["contract_instance_id"], name: "index_expenses_on_contract_instance_id"
    t.index ["cost_type_id"], name: "index_expenses_on_cost_type_id"
    t.index ["invoice_id"], name: "index_expenses_on_invoice_id"
  end

  create_table "income_taxes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "tax_rate", precision: 5, scale: 2, null: false
    t.string "tax_type", null: false
    t.datetime "updated_at", null: false
    t.index ["tax_type"], name: "index_income_taxes_on_tax_type", unique: true
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "calculation_mode"
    t.bigint "contract_instance_id"
    t.datetime "created_at", null: false
    t.date "end_date", null: false
    t.date "invoice_date", null: false
    t.string "invoice_number", default: "", null: false
    t.date "start_date", null: false
    t.integer "status", null: false
    t.integer "total_amount_cents", default: 0, null: false
    t.string "total_amount_currency", default: "JPY", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["contract_instance_id"], name: "index_invoices_on_contract_instance_id"
    t.index ["invoice_number"], name: "index_invoices_on_invoice_number", unique: true
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "payment_adjustments", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "JPY", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.string "description"
    t.integer "status", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["client_id"], name: "index_payment_adjustments_on_client_id"
    t.index ["user_id"], name: "index_payment_adjustments_on_user_id"
  end

  create_table "payment_allocations", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "JPY", null: false
    t.datetime "created_at", null: false
    t.bigint "income_tax_id", null: false
    t.bigint "payment_statement_id", null: false
    t.bigint "reference_id", null: false
    t.string "reference_type", null: false
    t.datetime "updated_at", null: false
    t.index ["income_tax_id"], name: "index_payment_allocations_on_income_tax_id"
    t.index ["payment_statement_id"], name: "index_payment_allocations_on_payment_statement_id"
    t.index ["reference_type", "reference_id"], name: "index_payment_allocations_on_reference"
  end

  create_table "payment_statements", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "JPY", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.date "received_on", null: false
    t.integer "status", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["client_id"], name: "index_payment_statements_on_client_id"
    t.index ["user_id"], name: "index_payment_statements_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
    t.index ["name"], name: "index_projects_on_name", unique: true
  end

  create_table "time_entries", force: :cascade do |t|
    t.integer "cost_cents", default: 0, null: false
    t.string "cost_currency", default: "JPY", null: false
    t.datetime "created_at", null: false
    t.date "date"
    t.bigint "invoice_id"
    t.string "name"
    t.bigint "project_id", null: false
    t.integer "spent_time_in_seconds", default: 0, null: false
    t.time "time_from"
    t.time "time_to"
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_time_entries_on_invoice_id"
    t.index ["project_id"], name: "index_time_entries_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clients", "users"
  add_foreign_key "contract_instances", "contracts"
  add_foreign_key "contracts", "clients"
  add_foreign_key "contracts", "users"
  add_foreign_key "cost_types", "users"
  add_foreign_key "expenses", "contract_instances"
  add_foreign_key "expenses", "cost_types"
  add_foreign_key "expenses", "invoices"
  add_foreign_key "invoices", "contract_instances"
  add_foreign_key "invoices", "users"
  add_foreign_key "payment_adjustments", "clients"
  add_foreign_key "payment_adjustments", "users"
  add_foreign_key "payment_allocations", "income_taxes"
  add_foreign_key "payment_allocations", "payment_statements"
  add_foreign_key "payment_statements", "clients"
  add_foreign_key "payment_statements", "users"
  add_foreign_key "projects", "clients"
  add_foreign_key "time_entries", "invoices"
  add_foreign_key "time_entries", "projects"
end
