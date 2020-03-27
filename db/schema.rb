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

ActiveRecord::Schema.define(version: 2020_03_25_204427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diffs", force: :cascade do |t|
    t.bigint "review_id", null: false
    t.string "status"
    t.text "notes"
    t.string "path"
    t.string "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id"], name: "index_diffs_on_review_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string "name"
    t.string "project"
    t.string "repo_location"
    t.string "local_copy"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "secret_path"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "repository_id", null: false
    t.date "start_date"
    t.string "status"
    t.string "owner"
    t.string "old_commit"
    t.string "new_commit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["repository_id"], name: "index_reviews_on_repository_id"
  end

  add_foreign_key "diffs", "reviews"
  add_foreign_key "reviews", "repositories"
end
