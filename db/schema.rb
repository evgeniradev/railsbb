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

ActiveRecord::Schema.define(version: 20180501201050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banned_ips", force: :cascade do |t|
    t.string   "ip_range"
    t.string   "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip_range"], name: "index_banned_ips_on_ip_range", unique: true, using: :btree
  end

  create_table "forums", force: :cascade do |t|
    t.integer  "section_id"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["section_id", "title"], name: "index_forums_on_section_id_and_title", unique: true, using: :btree
    t.index ["section_id"], name: "index_forums_on_section_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "forum_id"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.integer  "section_id"
    t.integer  "kind",       default: 0
    t.text     "content"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["forum_id"], name: "index_posts_on_forum_id", using: :btree
    t.index ["section_id"], name: "index_posts_on_section_id", using: :btree
    t.index ["topic_id"], name: "index_posts_on_topic_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "sections", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_sections_on_title", unique: true, using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.string   "title",                default: "Insert your title here"
    t.string   "description",          default: "Insert a short desccription here"
    t.string   "time_zone",            default: "UTC"
    t.string   "logo"
    t.text     "terms_and_conditions", default: ""
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.integer  "section_id"
    t.string   "title"
    t.integer  "views",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["forum_id", "title"], name: "index_topics_on_forum_id_and_title", unique: true, using: :btree
    t.index ["forum_id"], name: "index_topics_on_forum_id", using: :btree
    t.index ["section_id"], name: "index_topics_on_section_id", using: :btree
    t.index ["title"], name: "index_topics_on_title", using: :btree
    t.index ["user_id"], name: "index_topics_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                            null: false
    t.integer  "status",                 default: 0
    t.integer  "role",                   default: 0
    t.string   "avatar"
    t.string   "description",            default: ""
    t.boolean  "terms_and_conditions",                null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
