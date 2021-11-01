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

ActiveRecord::Schema.define(version: 2021_11_01_222029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_items", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "item_id"
    t.integer "invoice_id"
    t.integer "quantity"
    t.integer "unit_price"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "customer_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "name"
    t.string "description"
    t.integer "unit_price"
    t.integer "merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merchants", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "invoice_id"
    t.string "credit_card_number"
    t.string "credit_card_expiration_date"
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
