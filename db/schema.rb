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

ActiveRecord::Schema.define(version: 2020_05_23_233404) do

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

  create_table "languages", force: :cascade do |t|
    t.bigint "repository_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "url"
    t.index ["repository_id"], name: "index_languages_on_repository_id"
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

  create_table "rule_tags", force: :cascade do |t|
    t.bigint "rule_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rule_id"], name: "index_rule_tags_on_rule_id"
    t.index ["tag_id"], name: "index_rule_tags_on_tag_id"
  end

  create_table "rules", force: :cascade do |t|
    t.bigint "language_id", null: false
    t.string "category"
    t.text "title"
    t.text "body"
    t.text "more_info_links"
    t.string "severity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_rules_on_language_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "diffs", "reviews"
  add_foreign_key "languages", "repositories"
  add_foreign_key "reviews", "repositories"
  add_foreign_key "rule_tags", "rules"
  add_foreign_key "rule_tags", "tags"
  add_foreign_key "rules", "languages"
end
