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

ActiveRecord::Schema.define(version: 2018_10_24_074221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer "tradegecko_id"
    t.string "access_token"
    t.string "refresh_token"
    t.integer "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tradegecko_application_id"
    t.index ["tradegecko_application_id"], name: "index_accounts_on_tradegecko_application_id"
  end

  create_table "channels", force: :cascade do |t|
    t.integer "error_count"
    t.string "connection_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.bigint "tradegecko_application_id"
    t.jsonb "settings", default: {}
    t.integer "tradegecko_id"
    t.index ["account_id"], name: "index_channels_on_account_id"
    t.index ["tradegecko_application_id"], name: "index_channels_on_tradegecko_application_id"
  end

  create_table "error_logs", force: :cascade do |t|
    t.string "message"
    t.string "verb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "channel_id"
    t.bigint "resource_reference_id"
    t.index ["channel_id"], name: "index_error_logs_on_channel_id"
    t.index ["resource_reference_id"], name: "index_error_logs_on_resource_reference_id"
  end

  create_table "resource_references", force: :cascade do |t|
    t.integer "tradegecko_id"
    t.string "resource_type"
    t.integer "tradegecko_parent_id"
    t.string "display_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.bigint "channel_id"
    t.index ["account_id"], name: "index_resource_references_on_account_id"
    t.index ["channel_id"], name: "index_resource_references_on_channel_id"
  end

  create_table "tradegecko_applications", force: :cascade do |t|
    t.integer "oauth_application_id"
    t.string "client_id"
    t.string "client_secret"
  end

end
