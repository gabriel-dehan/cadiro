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

ActiveRecord::Schema.define(version: 2020_01_12_191420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analyses", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_analyses_on_item_id"
    t.index ["user_id"], name: "index_analyses_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "item_type"
    t.string "rarity"
    t.string "image"
    t.string "link"
    t.text "wiki_item_card"
    t.jsonb "stats"
    t.string "tags", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "league_analyses", force: :cascade do |t|
    t.bigint "league_id"
    t.bigint "analysis_id"
    t.float "max_buyout"
    t.float "min_sellout"
    t.string "buyout_currency"
    t.string "sellout_currency"
    t.integer "occurences", default: 0
    t.integer "trades", default: 0
    t.integer "estimated_swipe_difficulty"
    t.jsonb "search_params"
    t.string "search_id"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysis_id"], name: "index_league_analyses_on_analysis_id"
    t.index ["league_id"], name: "index_league_analyses_on_league_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.jsonb "currencies_prices"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "version"
    t.string "display"
    t.boolean "hardcore"
    t.boolean "active"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "pte_script"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "analyses", "items"
  add_foreign_key "analyses", "users"
  add_foreign_key "league_analyses", "analyses"
  add_foreign_key "league_analyses", "leagues"
end
