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

ActiveRecord::Schema.define(version: 2021_11_04_094009) do

  create_table "ads", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "position", limit: 191, null: false
    t.string "name", limit: 191, null: false
    t.text "tag", size: :long, null: false
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.index ["position"], name: "unique_position", unique: true
  end

  create_table "articles", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "editor_user_id", null: false
    t.integer "review_user_id"
    t.integer "parent_article_id"
    t.string "type", limit: 191, null: false
    t.string "title", limit: 191
    t.string "eyecatch_image_file_url", limit: 191
    t.string "thumbnail_image_file_url", limit: 191
    t.text "description"
    t.text "keywords"
    t.text "lead_text", size: :long
    t.text "main_text", size: :long
    t.text "finish_text", size: :long
    t.json "category_ids", null: false
    t.json "tag_ids", null: false
    t.string "status", limit: 191, default: "draft"
    t.datetime "publish_date"
    t.datetime "close_date"
    t.string "limited_publishing_key", limit: 191
    t.integer "fixed", default: 0
    t.boolean "root", default: false
    t.json "setting", null: false
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.timestamp "deleted_at"
    t.index ["editor_user_id"], name: "index_editor_user_id"
    t.index ["fixed"], name: "index_fixed"
    t.index ["parent_article_id"], name: "index_parent_article_id"
    t.index ["review_user_id"], name: "index_review_user_id"
    t.index ["root"], name: "index_root"
    t.index ["status"], name: "index_status"
    t.index ["type"], name: "index_type"
  end

  create_table "categories", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "host_user_id", null: false
    t.integer "parent_category_id"
    t.string "display_name", limit: 191, null: false
    t.string "slug", limit: 191, null: false
    t.text "detail"
    t.integer "order", null: false
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.timestamp "deleted_at"
    t.string "type", limit: 191, default: "article"
    t.index ["host_user_id"], name: "index_host_user_id"
    t.index ["parent_category_id"], name: "index_parent_category_id"
    t.index ["slug"], name: "index_slug"
    t.index ["type"], name: "index_type"
  end

  create_table "database_structures", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "editors", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.string "icon_image_file_url", limit: 191
    t.text "profile"
    t.string "email", limit: 191, null: false
    t.string "password", limit: 191, null: false
    t.integer "role", limit: 1, default: 0, null: false
    t.string "remember_token", limit: 100
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.timestamp "deleted_at"
    t.index ["email"], name: "editors_email_unique", unique: true
    t.index ["role"], name: "index_role"
  end

  create_table "favorites", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "data_type", limit: 191, null: false
    t.integer "data_id", null: false
    t.integer "folder_id", default: 0
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.index ["data_id"], name: "index_data_id"
    t.index ["data_type"], name: "index_data_type"
    t.index ["folder_id"], name: "index_folder_id"
    t.index ["user_id"], name: "index_user_id"
  end

  create_table "files", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "host_user_id", limit: 191, null: false
    t.string "display_name", limit: 191, null: false
    t.string "slug", limit: 191, null: false
    t.string "filetype", limit: 191, null: false
    t.text "detail"
    t.integer "private_level"
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.timestamp "deleted_at"
    t.index ["host_user_id"], name: "index_host_user_id"
    t.index ["slug"], name: "index_slug"
  end

  create_table "migrations", id: { type: :integer, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "migration", limit: 191, null: false
    t.integer "batch", null: false
  end

  create_table "oauth_access_token_providers", primary_key: "oauth_access_token_id", id: { type: :string, limit: 100 }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "provider", limit: 191, null: false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "oauth_access_tokens", id: { type: :string, limit: 100 }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "client_id", null: false, unsigned: true
    t.string "name", limit: 191
    t.text "scopes"
    t.boolean "revoked", null: false
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.datetime "expires_at"
    t.index ["user_id"], name: "oauth_access_tokens_user_id_index"
  end

  create_table "oauth_auth_codes", id: { type: :string, limit: 100 }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "client_id", null: false, unsigned: true
    t.text "scopes"
    t.boolean "revoked", null: false
    t.datetime "expires_at"
  end

  create_table "oauth_clients", id: { type: :integer, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", limit: 191, null: false
    t.string "secret", limit: 100, null: false
    t.text "redirect", null: false
    t.boolean "personal_access_client", null: false
    t.boolean "password_client", null: false
    t.boolean "revoked", null: false
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.index ["user_id"], name: "oauth_clients_user_id_index"
  end

  create_table "oauth_personal_access_clients", id: { type: :integer, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "client_id", null: false, unsigned: true
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.index ["client_id"], name: "oauth_personal_access_clients_client_id_index"
  end

  create_table "oauth_refresh_tokens", id: { type: :string, limit: 100 }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "access_token_id", limit: 100, null: false
    t.boolean "revoked", null: false
    t.datetime "expires_at"
    t.index ["access_token_id"], name: "oauth_refresh_tokens_access_token_id_index"
  end

  create_table "password_resets", id: false, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "email", limit: 191, null: false
    t.string "token", limit: 191, null: false
    t.timestamp "created_at"
    t.index ["email"], name: "password_resets_email_index"
  end

  create_table "re_auths", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "user_type", limit: 191, null: false
    t.integer "user_id", null: false
    t.string "key", limit: 191, null: false
    t.datetime "limit_time", null: false
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.timestamp "deleted_at"
    t.index ["key"], name: "index_reauth_key"
    t.index ["user_id"], name: "index_reauth_user_id"
  end

  create_table "tags", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "host_user_id", null: false
    t.string "display_name", limit: 191, null: false
    t.string "slug", limit: 191, null: false
    t.text "detail"
    t.integer "order", null: false
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.timestamp "deleted_at"
    t.index ["slug"], name: "index_slug"
  end

  create_table "thanks", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 191
    t.string "type", limit: 191, null: false
    t.string "source_url", limit: 191
    t.string "image_url", limit: 191
    t.text "detail", size: :long, null: false
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.timestamp "deleted_at"
  end

  create_table "upgrade_offers", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "request_role", null: false
    t.string "status", limit: 191, default: "pending"
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.timestamp "deleted_at"
    t.index ["user_id"], name: "index_user_id"
  end

  create_table "user_metas", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "real_name", limit: 191, null: false
    t.string "real_ruby", limit: 191, null: false
    t.string "sex", limit: 191, null: false
    t.date "birthday", null: false
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.timestamp "deleted_at"
    t.index ["birthday"], name: "index_birthday"
    t.index ["sex"], name: "index_sex"
    t.index ["user_id"], name: "unique_user_id", unique: true
  end

  create_table "users", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.string "email", limit: 191, null: false
    t.timestamp "email_verified_at"
    t.string "password", limit: 191, null: false
    t.integer "role", limit: 1, default: 0, null: false
    t.string "icon_image_file_url", limit: 191
    t.string "remember_token", limit: 100
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.timestamp "deleted_at"
    t.index ["email"], name: "users_email_unique", unique: true
    t.index ["role"], name: "index_role"
  end

  create_table "views", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "date_num", null: false
    t.integer "article_id", null: false
    t.string "type", limit: 191, null: false
    t.integer "count", default: 0
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.index ["article_id"], name: "index_article_id"
    t.index ["date_num"], name: "index_date_num"
    t.index ["type"], name: "index_type"
  end

  create_table "voices", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "editor_user_id", null: false
    t.integer "review_user_id"
    t.integer "parent_article_id"
    t.string "type", limit: 191, null: false
    t.string "title", limit: 191
    t.string "eyecatch_image_file_url", limit: 191
    t.string "thumbnail_image_file_url", limit: 191
    t.text "lead_text"
    t.text "main_text"
    t.text "finish_text"
    t.json "category_ids"
    t.json "tag_ids"
    t.string "status", limit: 191, default: "draft"
    t.datetime "publish_date"
    t.datetime "close_date"
    t.string "limited_publishing_key", limit: 191
    t.integer "fixed", default: 0
    t.boolean "root", default: false
    t.json "setting", null: false
    t.timestamp "creation_date"
    t.timestamp "last_update"
    t.timestamp "deleted_at"
    t.index ["editor_user_id"], name: "index_editor_user_id"
    t.index ["fixed"], name: "index_fixed"
    t.index ["parent_article_id"], name: "index_parent_article_id"
    t.index ["review_user_id"], name: "index_review_user_id"
    t.index ["root"], name: "index_root"
    t.index ["status"], name: "index_status"
    t.index ["type"], name: "index_type"
  end

  add_foreign_key "oauth_access_token_providers", "oauth_access_tokens", name: "oauth_access_token_providers_oauth_access_token_id_foreign", on_delete: :cascade
end
