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

ActiveRecord::Schema.define(version: 2017_07_18_202445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_encrypting_keys", force: :cascade do |t|
    t.string "encrypted_key"
    t.boolean "primary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "encrypted_strings", force: :cascade do |t|
    t.string "encrypted_value"
    t.string "encrypted_value_iv"
    t.string "encrypted_value_salt"
    t.bigint "data_encrypting_key_id"
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_encrypting_key_id"], name: "index_encrypted_strings_on_data_encrypting_key_id"
    t.index ["token"], name: "index_encrypted_strings_on_token"
  end

  add_foreign_key "encrypted_strings", "data_encrypting_keys"
end
