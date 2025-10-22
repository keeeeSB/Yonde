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

ActiveRecord::Schema[8.0].define(version: 2025_10_18_225854) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_authors_on_name", unique: true
  end

  create_table "authorships", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id", "book_id"], name: "index_authorships_on_author_id_and_book_id", unique: true
    t.index ["book_id"], name: "index_authorships_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.date "published_date"
    t.text "description"
    t.string "systemid", null: false
    t.integer "page_count"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["systemid"], name: "index_books_on_systemid", unique: true
  end

  create_table "child_reading_logs", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.bigint "reading_log_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id", "reading_log_id"], name: "index_child_reading_logs_on_child_id_and_reading_log_id", unique: true
    t.index ["reading_log_id"], name: "index_child_reading_logs_on_reading_log_id"
  end

  create_table "children", force: :cascade do |t|
    t.string "name", null: false
    t.date "birthday", null: false
    t.integer "gender", null: false
    t.bigint "family_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_children_on_family_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "reading_log_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reading_log_id"], name: "index_comments_on_reading_log_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "family_libraries", force: :cascade do |t|
    t.bigint "family_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_family_libraries_on_family_id"
  end

  create_table "library_books", force: :cascade do |t|
    t.bigint "family_library_id", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_library_books_on_book_id"
    t.index ["family_library_id", "book_id"], name: "index_library_books_on_family_library_id_and_book_id", unique: true
  end

  create_table "reading_logs", force: :cascade do |t|
    t.date "read_on", null: false
    t.integer "rating", null: false
    t.text "memo"
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.bigint "family_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reading_logs_on_book_id"
    t.index ["family_id"], name: "index_reading_logs_on_family_id"
    t.index ["user_id"], name: "index_reading_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "family_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["family_id"], name: "index_users_on_family_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "authorships", "authors"
  add_foreign_key "authorships", "books"
  add_foreign_key "child_reading_logs", "children"
  add_foreign_key "child_reading_logs", "reading_logs"
  add_foreign_key "children", "families"
  add_foreign_key "comments", "reading_logs"
  add_foreign_key "comments", "users"
  add_foreign_key "family_libraries", "families"
  add_foreign_key "library_books", "books"
  add_foreign_key "library_books", "family_libraries"
  add_foreign_key "reading_logs", "books"
  add_foreign_key "reading_logs", "families"
  add_foreign_key "reading_logs", "users"
  add_foreign_key "users", "families"
end
