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

ActiveRecord::Schema[7.0].define(version: 2023_08_05_054239) do
  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "followings", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_id"], name: "index_followings_on_followee_id"
    t.index ["follower_id"], name: "index_followings_on_follower_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_id"], name: "index_follows_on_followee_id"
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "list_posts", force: :cascade do |t|
    t.integer "list_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_list_posts_on_list_id"
    t.index ["post_id"], name: "index_list_posts_on_post_id"
  end

  create_table "list_sharings", force: :cascade do |t|
    t.integer "list_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_list_sharings_on_list_id"
    t.index ["user_id"], name: "index_list_sharings_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.string "featured_image"
    t.datetime "published_at"
    t.integer "topic_id", null: false
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "views_count", default: 0
    t.float "score"
    t.integer "reading_time"
    t.boolean "draft", default: false
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["topic_id"], name: "index_posts_on_topic_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_user_id", null: false
    t.integer "followee_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_user_id"], name: "index_relationships_on_followee_user_id"
    t.index ["follower_user_id"], name: "index_relationships_on_follower_user_id"
  end

  create_table "saved_posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_saved_posts_on_post_id"
    t.index ["user_id"], name: "index_saved_posts_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_author_views", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "author_id", null: false
    t.integer "view_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_user_author_views_on_author_id"
    t.index ["user_id"], name: "index_user_author_views_on_user_id"
  end

  create_table "user_post_views", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "views_count", default: 0
    t.index ["post_id"], name: "index_user_post_views_on_post_id"
    t.index ["user_id"], name: "index_user_post_views_on_user_id"
  end

  create_table "user_topic_views", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "topic_id", null: false
    t.integer "view_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_user_topic_views_on_topic_id"
    t.index ["user_id"], name: "index_user_topic_views_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "followings", "followees"
  add_foreign_key "followings", "followers"
  add_foreign_key "follows", "followees"
  add_foreign_key "follows", "followers"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "list_posts", "lists"
  add_foreign_key "list_posts", "posts"
  add_foreign_key "list_sharings", "lists"
  add_foreign_key "list_sharings", "users"
  add_foreign_key "lists", "users"
  add_foreign_key "posts", "topics"
  add_foreign_key "posts", "users", column: "author_id"
  add_foreign_key "relationships", "users", column: "followee_user_id"
  add_foreign_key "relationships", "users", column: "follower_user_id"
  add_foreign_key "saved_posts", "posts"
  add_foreign_key "saved_posts", "users"
  add_foreign_key "user_author_views", "users"
  add_foreign_key "user_author_views", "users", column: "author_id"
  add_foreign_key "user_post_views", "posts"
  add_foreign_key "user_post_views", "users"
  add_foreign_key "user_topic_views", "topics"
  add_foreign_key "user_topic_views", "users"
end
