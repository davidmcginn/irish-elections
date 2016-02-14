# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160214195409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "candidates", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "aka"
    t.date     "date_of_birth"
    t.string   "gender"
    t.boolean  "current_td",                                 default: false, null: false
    t.text     "photo_url"
    t.text     "party_profile_url"
    t.text     "website_url"
    t.text     "twitter_handle"
    t.text     "facebook_url"
    t.text     "instagram_url"
    t.text     "linkedin_url"
    t.text     "youtube_url"
    t.text     "source_url"
    t.text     "voting_record_url"
    t.decimal  "claimed_expenses",   precision: 9, scale: 2
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.integer  "party_id"
    t.integer  "constituency_id"
    t.string   "email"
    t.string   "slug"
    t.boolean  "current_councillor",                         default: false, null: false
    t.boolean  "current_senator",                            default: false, null: false
    t.text     "snapchat_url"
    t.string   "phone_1"
    t.string   "phone_2"
  end

  create_table "constituencies", force: :cascade do |t|
    t.string  "name",                     null: false
    t.string  "slug"
    t.integer "num_seats",    default: 0, null: false
    t.string  "twitter_list"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "parties", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug"
  end

  create_table "social_counts", force: :cascade do |t|
    t.integer  "candidate_id"
    t.integer  "twitter_followers_count"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_counts", ["candidate_id", "date"], name: "index_social_counts_on_candidate_id_and_date", unique: true, using: :btree

end
