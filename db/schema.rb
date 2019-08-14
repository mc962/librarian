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

ActiveRecord::Schema.define(version: 2019_07_13_032127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codelets", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description", null: false
    t.boolean "publicly_accessible", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_codelets_on_name", unique: true
    t.index ["slug"], name: "index_codelets_on_slug", unique: true
  end

  create_table "examples", force: :cascade do |t|
    t.text "command", null: false
    t.text "output"
    t.text "comment"
    t.bigint "codelet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codelet_id"], name: "index_examples_on_codelet_id"
    t.index ["command"], name: "index_examples_on_command"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  add_foreign_key "examples", "codelets"
end
