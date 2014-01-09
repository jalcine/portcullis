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

ActiveRecord::Schema.define(version: 20140109065703) do

  create_table "age_groups", force: true do |t|
    t.string   "name"
    t.integer  "max_age"
    t.integer  "min_age"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "age_groups_events", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "age_group_id"
  end

  add_index "age_groups_events", ["age_group_id"], name: "index_age_groups_events_on_age_group_id", using: :btree
  add_index "age_groups_events", ["event_id"], name: "index_age_groups_events_on_event_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id", using: :btree
  add_index "categories", ["event_id"], name: "index_categories_on_event_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "date_start"
    t.datetime "date_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.string   "address"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.integer  "secondary_category_id"
    t.integer  "primary_category_id"
    t.string   "banner"
    t.boolean  "publicity"
  end

  add_index "events", ["primary_category_id"], name: "index_events_on_primary_category_id", using: :btree
  add_index "events", ["secondary_category_id"], name: "index_events_on_secondary_category_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",         default: 0
    t.integer  "quantity",       default: 0
    t.decimal  "charge",         default: 0.0
    t.integer  "transaction_id"
  end

  add_index "orders", ["ticket_id"], name: "index_orders_on_ticket_id", using: :btree
  add_index "orders", ["transaction_id"], name: "index_orders_on_transaction_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.datetime "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.string   "address"
    t.string   "avatar",        default: "", null: false
    t.integer  "user_id"
  end

  create_table "providers", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
  end

  add_index "providers", ["uid"], name: "index_providers_on_uid", unique: true, order: {"uid"=>:desc}, using: :btree
  add_index "providers", ["user_id"], name: "index_providers_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "tickets", force: true do |t|
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "max_quantity"
    t.integer  "quantity"
    t.datetime "date_end"
    t.datetime "date_start"
    t.decimal  "price",        precision: 8, scale: 2
    t.text     "description",                          default: "", null: false
  end

  add_index "tickets", ["event_id"], name: "index_tickets_on_event_id", using: :btree

  create_table "transactions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
