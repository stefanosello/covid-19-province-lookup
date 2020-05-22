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

ActiveRecord::Schema.define(version: 2020_05_22_101825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "epidemic_data", force: :cascade do |t|
    t.datetime "date"
    t.integer "total_cases"
    t.string "province_code"
    t.json "notes"
    t.index ["date", "province_code"], name: "uniq_epidemic_data_index", unique: true
  end

  create_table "nations", primary_key: "code", id: :string, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_nations_on_code", unique: true
  end

  create_table "provinces", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "label"
    t.string "region_code"
    t.string "initials"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_provinces_on_code", unique: true
    t.index ["initials"], name: "index_provinces_on_initials", unique: true
    t.index ["label"], name: "index_provinces_on_label"
    t.index ["latitude", "longitude"], name: "index_provinces_on_latitude_and_longitude"
  end

  create_table "regions", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "label"
    t.string "nation_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_regions_on_code", unique: true
    t.index ["label"], name: "index_regions_on_label", unique: true
  end

  add_foreign_key "epidemic_data", "provinces", column: "province_code", primary_key: "code", on_delete: :cascade
  add_foreign_key "provinces", "regions", column: "region_code", primary_key: "code", on_delete: :cascade
  add_foreign_key "regions", "nations", column: "nation_code", primary_key: "code", on_delete: :cascade
end
