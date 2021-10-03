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

ActiveRecord::Schema.define(version: 2021_10_03_082241) do

  create_table "direct_messages", force: :cascade do |t|
    t.integer "matching_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sender_id", null: false
    t.index ["matching_id"], name: "index_direct_messages_on_matching_id"
    t.index ["sender_id"], name: "index_direct_messages_on_sender_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "liker_id", null: false
    t.integer "liked_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["liked_id"], name: "index_likes_on_liked_id"
    t.index ["liker_id"], name: "index_likes_on_liker_id"
  end

  create_table "matchings", force: :cascade do |t|
    t.integer "user1_id", null: false
    t.integer "user2_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user1_id"], name: "index_matchings_on_user1_id"
    t.index ["user2_id"], name: "index_matchings_on_user2_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tournament_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["tournament_id"], name: "index_participants_on_tournament_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.integer "participant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tournament_id", null: false
    t.index ["participant_id"], name: "index_posts_on_participant_id"
    t.index ["tournament_id"], name: "index_posts_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.time "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "web"
    t.integer "crypt"
    t.integer "reversing"
    t.integer "pwn"
    t.integer "misc"
    t.text "self_introduction"
    t.string "remember_digest"
  end

  add_foreign_key "direct_messages", "matchings"
  add_foreign_key "direct_messages", "users", column: "sender_id"
  add_foreign_key "likes", "users", column: "liked_id"
  add_foreign_key "likes", "users", column: "liker_id"
  add_foreign_key "matchings", "users", column: "user1_id"
  add_foreign_key "matchings", "users", column: "user2_id"
  add_foreign_key "participants", "tournaments"
  add_foreign_key "participants", "users"
  add_foreign_key "posts", "participants"
  add_foreign_key "posts", "tournaments"
end
