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

ActiveRecord::Schema.define(version: 20150828192208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "hstore"

  create_table "change_payloads", force: :cascade do |t|
    t.json     "payload"
    t.integer  "changeset_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "change_payloads", ["changeset_id"], name: "index_change_payloads_on_changeset_id", using: :btree

  create_table "changesets", force: :cascade do |t|
    t.text     "notes"
    t.boolean  "applied"
    t.datetime "applied_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "current_operators", force: :cascade do |t|
    t.string    "name"
    t.hstore    "tags"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.string    "onestop_id"
    t.geography "geometry",                           limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.integer   "created_or_updated_in_changeset_id"
    t.integer   "version"
    t.string    "identifiers",                                                                                    default: [], array: true
    t.string    "timezone"
    t.string    "short_name"
    t.string    "website"
    t.string    "country"
    t.string    "state"
    t.string    "metro"
  end

  add_index "current_operators", ["created_or_updated_in_changeset_id"], name: "#c_operators_cu_in_changeset_id_index", using: :btree
  add_index "current_operators", ["identifiers"], name: "index_current_operators_on_identifiers", using: :gin
  add_index "current_operators", ["onestop_id"], name: "index_current_operators_on_onestop_id", unique: true, using: :btree
  add_index "current_operators", ["tags"], name: "index_current_operators_on_tags", using: :btree
  add_index "current_operators", ["updated_at"], name: "index_current_operators_on_updated_at", using: :btree

  create_table "current_operators_serving_stop", force: :cascade do |t|
    t.integer  "stop_id",                            null: false
    t.integer  "operator_id",                        null: false
    t.hstore   "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_or_updated_in_changeset_id"
    t.integer  "version"
  end

  add_index "current_operators_serving_stop", ["created_or_updated_in_changeset_id"], name: "#c_operators_serving_stop_cu_in_changeset_id_index", using: :btree
  add_index "current_operators_serving_stop", ["operator_id"], name: "index_current_operators_serving_stop_on_operator_id", using: :btree
  add_index "current_operators_serving_stop", ["stop_id", "operator_id"], name: "index_current_operators_serving_stop_on_stop_id_and_operator_id", unique: true, using: :btree
  add_index "current_operators_serving_stop", ["stop_id"], name: "index_current_operators_serving_stop_on_stop_id", using: :btree

  create_table "current_routes", force: :cascade do |t|
    t.string    "onestop_id"
    t.string    "name"
    t.hstore    "tags"
    t.integer   "operator_id"
    t.integer   "created_or_updated_in_changeset_id"
    t.integer   "version"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.geography "geometry",                           limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.string    "identifiers",                                                                                    default: [], array: true
  end

  add_index "current_routes", ["created_or_updated_in_changeset_id"], name: "c_route_cu_in_changeset", using: :btree
  add_index "current_routes", ["identifiers"], name: "index_current_routes_on_identifiers", using: :gin
  add_index "current_routes", ["operator_id"], name: "index_current_routes_on_operator_id", using: :btree
  add_index "current_routes", ["tags"], name: "index_current_routes_on_tags", using: :btree
  add_index "current_routes", ["updated_at"], name: "index_current_routes_on_updated_at", using: :btree

  create_table "current_routes_serving_stop", force: :cascade do |t|
    t.integer  "route_id"
    t.integer  "stop_id"
    t.hstore   "tags"
    t.integer  "created_or_updated_in_changeset_id"
    t.integer  "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "current_routes_serving_stop", ["created_or_updated_in_changeset_id"], name: "c_rss_cu_in_changeset", using: :btree
  add_index "current_routes_serving_stop", ["route_id"], name: "index_current_routes_serving_stop_on_route_id", using: :btree
  add_index "current_routes_serving_stop", ["stop_id"], name: "index_current_routes_serving_stop_on_stop_id", using: :btree

  create_table "current_schedule_stop_pairs", force: :cascade do |t|
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.integer  "route_id"
    t.string   "trip"
    t.integer  "created_or_updated_in_changeset_id"
    t.integer  "version"
    t.string   "trip_headsign"
    t.string   "origin_arrival_time"
    t.string   "origin_departure_time"
    t.string   "destination_arrival_time"
    t.string   "destination_departure_time"
    t.string   "frequency_start_time"
    t.string   "frequency_end_time"
    t.string   "frequency_headway_seconds"
    t.hstore   "tags"
    t.date     "service_start_date"
    t.date     "service_end_date"
    t.date     "service_added_dates",                default: [],              array: true
    t.date     "service_except_dates",               default: [],              array: true
    t.boolean  "service_days_of_week",               default: [],              array: true
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "block_id"
    t.string   "trip_short_name"
    t.integer  "wheelchair_accessible"
    t.integer  "bikes_allowed"
    t.integer  "pickup_type"
    t.integer  "drop_off_type"
    t.integer  "timepoint"
    t.float    "shape_dist_traveled"
    t.string   "origin_timezone"
    t.string   "destination_timezone"
  end

  add_index "current_schedule_stop_pairs", ["created_or_updated_in_changeset_id"], name: "c_ssp_cu_in_changeset", using: :btree
  add_index "current_schedule_stop_pairs", ["destination_id"], name: "c_ssp_destination", using: :btree
  add_index "current_schedule_stop_pairs", ["origin_id"], name: "c_ssp_origin", using: :btree
  add_index "current_schedule_stop_pairs", ["route_id"], name: "c_ssp_route", using: :btree
  add_index "current_schedule_stop_pairs", ["service_end_date"], name: "c_ssp_service_end_date", using: :btree
  add_index "current_schedule_stop_pairs", ["service_start_date"], name: "c_ssp_service_start_date", using: :btree
  add_index "current_schedule_stop_pairs", ["trip"], name: "c_ssp_trip", using: :btree
  add_index "current_schedule_stop_pairs", ["updated_at"], name: "index_current_schedule_stop_pairs_on_updated_at", using: :btree

  create_table "current_stops", force: :cascade do |t|
    t.string    "onestop_id"
    t.geography "geometry",                           limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.hstore    "tags"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.string    "name"
    t.integer   "created_or_updated_in_changeset_id"
    t.integer   "version"
    t.string    "identifiers",                                                                                    default: [], array: true
    t.string    "timezone"
  end

  add_index "current_stops", ["created_or_updated_in_changeset_id"], name: "#c_stops_cu_in_changeset_id_index", using: :btree
  add_index "current_stops", ["identifiers"], name: "index_current_stops_on_identifiers", using: :gin
  add_index "current_stops", ["onestop_id"], name: "index_current_stops_on_onestop_id", using: :btree
  add_index "current_stops", ["tags"], name: "index_current_stops_on_tags", using: :btree
  add_index "current_stops", ["updated_at"], name: "index_current_stops_on_updated_at", using: :btree

  create_table "feed_imports", force: :cascade do |t|
    t.integer  "feed_id"
    t.boolean  "success"
    t.string   "sha1"
    t.text     "import_log"
    t.text     "validation_report"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feed_imports", ["created_at"], name: "index_feed_imports_on_created_at", using: :btree
  add_index "feed_imports", ["feed_id"], name: "index_feed_imports_on_feed_id", using: :btree

  create_table "feeds", force: :cascade do |t|
    t.string   "onestop_id"
    t.string   "url"
    t.string   "feed_format"
    t.hstore   "tags"
    t.string   "last_sha1"
    t.datetime "last_fetched_at"
    t.datetime "last_imported_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "license_name"
    t.string   "license_url"
    t.string   "license_use_without_attribution"
    t.string   "license_create_derived_product"
    t.string   "license_redistribute"
    t.hstore   "operators_in_feed",               array: true
  end

  add_index "feeds", ["onestop_id"], name: "index_feeds_on_onestop_id", using: :btree
  add_index "feeds", ["tags"], name: "index_feeds_on_tags", using: :btree

  create_table "old_operators", force: :cascade do |t|
    t.string    "name"
    t.hstore    "tags"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.string    "onestop_id"
    t.geography "geometry",                           limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.integer   "created_or_updated_in_changeset_id"
    t.integer   "destroyed_in_changeset_id"
    t.integer   "current_id"
    t.integer   "version"
    t.string    "identifiers",                                                                                    default: [], array: true
    t.string    "timezone"
    t.string    "short_name"
    t.string    "website"
    t.string    "country"
    t.string    "state"
    t.string    "metro"
  end

  add_index "old_operators", ["created_or_updated_in_changeset_id"], name: "o_operators_cu_in_changeset_id_index", using: :btree
  add_index "old_operators", ["current_id"], name: "index_old_operators_on_current_id", using: :btree
  add_index "old_operators", ["destroyed_in_changeset_id"], name: "operators_d_in_changeset_id_index", using: :btree
  add_index "old_operators", ["identifiers"], name: "index_old_operators_on_identifiers", using: :gin

  create_table "old_operators_serving_stop", force: :cascade do |t|
    t.integer  "stop_id"
    t.integer  "operator_id"
    t.hstore   "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_or_updated_in_changeset_id"
    t.integer  "destroyed_in_changeset_id"
    t.integer  "current_id"
    t.integer  "version"
    t.string   "stop_type"
    t.string   "operator_type"
  end

  add_index "old_operators_serving_stop", ["created_or_updated_in_changeset_id"], name: "o_operators_serving_stop_cu_in_changeset_id_index", using: :btree
  add_index "old_operators_serving_stop", ["current_id"], name: "index_old_operators_serving_stop_on_current_id", using: :btree
  add_index "old_operators_serving_stop", ["destroyed_in_changeset_id"], name: "operators_serving_stop_d_in_changeset_id_index", using: :btree
  add_index "old_operators_serving_stop", ["operator_type", "operator_id"], name: "operators_serving_stop_operator", using: :btree
  add_index "old_operators_serving_stop", ["stop_type", "stop_id"], name: "operators_serving_stop_stop", using: :btree

  create_table "old_routes", force: :cascade do |t|
    t.string    "onestop_id"
    t.string    "name"
    t.hstore    "tags"
    t.integer   "operator_id"
    t.string    "operator_type"
    t.integer   "created_or_updated_in_changeset_id"
    t.integer   "destroyed_in_changeset_id"
    t.integer   "current_id"
    t.integer   "version"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.geography "geometry",                           limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.string    "identifiers",                                                                                    default: [], array: true
  end

  add_index "old_routes", ["created_or_updated_in_changeset_id"], name: "o_route_cu_in_changeset", using: :btree
  add_index "old_routes", ["current_id"], name: "index_old_routes_on_current_id", using: :btree
  add_index "old_routes", ["destroyed_in_changeset_id"], name: "o_route_d_in_changeset", using: :btree
  add_index "old_routes", ["identifiers"], name: "index_old_routes_on_identifiers", using: :gin
  add_index "old_routes", ["operator_type", "operator_id"], name: "index_old_routes_on_operator_type_and_operator_id", using: :btree

  create_table "old_routes_serving_stop", force: :cascade do |t|
    t.integer  "route_id"
    t.string   "route_type"
    t.integer  "stop_id"
    t.string   "stop_type"
    t.hstore   "tags"
    t.integer  "created_or_updated_in_changeset_id"
    t.integer  "destroyed_in_changeset_id"
    t.integer  "current_id"
    t.integer  "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "old_routes_serving_stop", ["created_or_updated_in_changeset_id"], name: "o_rss_cu_in_changeset", using: :btree
  add_index "old_routes_serving_stop", ["current_id"], name: "index_old_routes_serving_stop_on_current_id", using: :btree
  add_index "old_routes_serving_stop", ["destroyed_in_changeset_id"], name: "o_rss_d_in_changeset", using: :btree
  add_index "old_routes_serving_stop", ["route_type", "route_id"], name: "index_old_routes_serving_stop_on_route_type_and_route_id", using: :btree
  add_index "old_routes_serving_stop", ["stop_type", "stop_id"], name: "index_old_routes_serving_stop_on_stop_type_and_stop_id", using: :btree

  create_table "old_schedule_stop_pairs", force: :cascade do |t|
    t.integer  "origin_id"
    t.string   "origin_type"
    t.integer  "destination_id"
    t.string   "destination_type"
    t.integer  "route_id"
    t.string   "route_type"
    t.string   "trip"
    t.integer  "current_id"
    t.integer  "created_or_updated_in_changeset_id"
    t.integer  "destroyed_in_changeset_id"
    t.integer  "version"
    t.string   "trip_headsign"
    t.string   "origin_arrival_time"
    t.string   "origin_departure_time"
    t.string   "destination_arrival_time"
    t.string   "destination_departure_time"
    t.string   "frequency_start_time"
    t.string   "frequency_end_time"
    t.string   "frequency_headway_seconds"
    t.hstore   "tags"
    t.date     "service_start_date"
    t.date     "service_end_date"
    t.date     "service_added_dates",                default: [],              array: true
    t.date     "service_except_dates",               default: [],              array: true
    t.boolean  "service_days_of_week",               default: [],              array: true
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "block_id"
    t.string   "trip_short_name"
    t.integer  "wheelchair_accessible"
    t.integer  "bikes_allowed"
    t.integer  "pickup_type"
    t.integer  "drop_off_type"
    t.integer  "timepoint"
    t.float    "shape_dist_traveled"
    t.string   "origin_timezone"
    t.string   "destination_timezone"
  end

  add_index "old_schedule_stop_pairs", ["created_or_updated_in_changeset_id"], name: "o_ssp_cu_in_changeset", using: :btree
  add_index "old_schedule_stop_pairs", ["current_id"], name: "index_old_schedule_stop_pairs_on_current_id", using: :btree
  add_index "old_schedule_stop_pairs", ["destination_type", "destination_id"], name: "o_ssp_destination", using: :btree
  add_index "old_schedule_stop_pairs", ["destroyed_in_changeset_id"], name: "o_ssp_d_in_changeset", using: :btree
  add_index "old_schedule_stop_pairs", ["origin_type", "origin_id"], name: "o_ssp_origin", using: :btree
  add_index "old_schedule_stop_pairs", ["route_type", "route_id"], name: "o_ssp_route", using: :btree
  add_index "old_schedule_stop_pairs", ["service_end_date"], name: "o_ssp_service_end_date", using: :btree
  add_index "old_schedule_stop_pairs", ["service_start_date"], name: "o_ssp_service_start_date", using: :btree
  add_index "old_schedule_stop_pairs", ["trip"], name: "o_ssp_trip", using: :btree

  create_table "old_stops", force: :cascade do |t|
    t.string    "onestop_id"
    t.geography "geometry",                           limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.hstore    "tags"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.string    "name"
    t.integer   "created_or_updated_in_changeset_id"
    t.integer   "destroyed_in_changeset_id"
    t.integer   "current_id"
    t.integer   "version"
    t.string    "identifiers",                                                                                    default: [], array: true
    t.string    "timezone"
  end

  add_index "old_stops", ["created_or_updated_in_changeset_id"], name: "o_stops_cu_in_changeset_id_index", using: :btree
  add_index "old_stops", ["current_id"], name: "index_old_stops_on_current_id", using: :btree
  add_index "old_stops", ["destroyed_in_changeset_id"], name: "stops_d_in_changeset_id_index", using: :btree
  add_index "old_stops", ["identifiers"], name: "index_old_stops_on_identifiers", using: :gin

  add_foreign_key "change_payloads", "changesets"
end
