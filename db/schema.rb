# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_26_051744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_feeds", force: :cascade do |t|
    t.bigint "board_id"
    t.bigint "feed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_board_feeds_on_board_id"
    t.index ["feed_id"], name: "index_board_feeds_on_feed_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", force: :cascade do |t|
    t.bigint "feed_id"
    t.string "title"
    t.string "link"
    t.string "eye_catching_image"
    t.text "description"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_entries_on_feed_id"
    t.index ["published_at"], name: "index_entries_on_published_at", order: :desc
  end

  create_table "feed_taggings", force: :cascade do |t|
    t.bigint "feed_id"
    t.bigint "feed_tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_feed_taggings_on_feed_id"
    t.index ["feed_tag_id"], name: "index_feed_taggings_on_feed_tag_id"
  end

  create_table "feed_tags", force: :cascade do |t|
    t.string "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feeds", force: :cascade do |t|
    t.string "title", null: false
    t.string "endpoint", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_published_at"
    t.boolean "suspend", default: false, null: false
  end

end
