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

ActiveRecord::Schema[7.0].define(version: 2022_09_29_075843) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disbursements", force: :cascade do |t|
    t.bigint "merchant_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "currency", default: "EUR", null: false
    t.string "week", null: false
    t.index ["merchant_id", "week"], name: "idx_merchant_disbursements_per_week", unique: true
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "cif", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "merchant_id", null: false
    t.bigint "shopper_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "currency", default: "EUR", null: false
    t.datetime "created_at", null: false
    t.datetime "completed_at"
    t.integer "disbursed_amount_cents"
    t.index ["merchant_id"], name: "index_orders_on_merchant_id"
    t.index ["shopper_id"], name: "index_orders_on_shopper_id"
  end

  create_table "shoppers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "nif", null: false
  end

  add_foreign_key "disbursements", "merchants"
  add_foreign_key "orders", "merchants"
  add_foreign_key "orders", "shoppers"
end
