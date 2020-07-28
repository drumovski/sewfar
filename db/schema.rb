# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_28_011405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "garments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "patterns", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "sizes"
    t.string "fabric"
    t.integer "fabric_amount"
    t.integer "category"
    t.float "price"
    t.text "description"
    t.integer "difficulty"
    t.text "notions"
    t.boolean "complete"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "garment_id"
    t.index ["user_id"], name: "index_patterns_on_user_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "business_name"
    t.string "abn"
    t.string "website"
    t.string "facebook"
    t.string "twitter"
    t.string "linkedin"
    t.string "instagram"
    t.text "about"
    t.text "address_line_1"
    t.text "address_line_2"
    t.string "city"
    t.string "postcode"
    t.string "country"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_sellers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "username"
    t.boolean "is_seller"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "patterns", "users"
  add_foreign_key "sellers", "users"
end
