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

ActiveRecord::Schema.define(version: 2020_03_27_154546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_orders", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_orders_on_item_id"
    t.index ["order_id"], name: "index_item_orders_on_order_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.bigint "currency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_items_on_currency_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "subtotal"
    t.integer "total"
    t.bigint "currency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_orders_on_currency_id"
  end

  create_table "pricing_rules", force: :cascade do |t|
    t.string "name"
    t.boolean "apply_last", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restriction_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pricing_rule_id"
    t.index ["pricing_rule_id"], name: "index_restriction_groups_on_pricing_rule_id"
  end

  create_table "restriction_type_minimum_item_quantities", force: :cascade do |t|
    t.bigint "item_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_restriction_type_minimum_item_quantities_on_item_id"
  end

  create_table "restriction_type_minimum_order_values", force: :cascade do |t|
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restriction_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restrictions", force: :cascade do |t|
    t.bigint "restriction_group_id"
    t.bigint "restriction_type_id"
    t.integer "restriction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restriction_group_id"], name: "index_restrictions_on_restriction_group_id"
    t.index ["restriction_type_id"], name: "index_restrictions_on_restriction_type_id"
  end

  create_table "reward_type_percent_offs", force: :cascade do |t|
    t.decimal "percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reward_type_value_offs", force: :cascade do |t|
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reward_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rewards", force: :cascade do |t|
    t.bigint "reward_type_id"
    t.integer "reward_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pricing_rule_id"
    t.index ["pricing_rule_id"], name: "index_rewards_on_pricing_rule_id"
    t.index ["reward_type_id"], name: "index_rewards_on_reward_type_id"
  end

  add_foreign_key "item_orders", "items"
  add_foreign_key "item_orders", "orders"
  add_foreign_key "items", "currencies"
  add_foreign_key "orders", "currencies"
  add_foreign_key "restriction_groups", "pricing_rules"
  add_foreign_key "restriction_type_minimum_item_quantities", "items"
  add_foreign_key "restrictions", "restriction_groups"
  add_foreign_key "restrictions", "restriction_types"
  add_foreign_key "rewards", "pricing_rules"
  add_foreign_key "rewards", "reward_types"
end
