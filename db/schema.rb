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

ActiveRecord::Schema.define(version: 20170902055047) do

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.integer "owner_id"
    t.index ["name", "owner_id"], name: "index_pets_on_name_and_owner_id", unique: true
    t.index ["owner_id"], name: "index_pets_on_owner_id"
  end

  create_table "pets_stays", id: false, force: :cascade do |t|
    t.integer "pet_id"
    t.integer "stay_id"
    t.index ["pet_id"], name: "index_pets_stays_on_pet_id"
    t.index ["stay_id"], name: "index_pets_stays_on_stay_id"
  end

  create_table "stays", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "rating"
    t.integer "sitter_id"
    t.integer "pet_owner_id"
    t.string "text"
    t.index ["pet_owner_id"], name: "index_stays_on_pet_owner_id"
    t.index ["sitter_id"], name: "index_stays_on_sitter_id"
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_url"
    t.string "phone_number"
    t.string "first_name"
    t.string "last_name"
    t.integer "roles_mask", default: 1, null: false
    t.decimal "sitter_score"
    t.decimal "rating_score"
    t.decimal "overall_score"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
