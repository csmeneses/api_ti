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

ActiveRecord::Schema.define(version: 2021_04_28_214005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "id_album"
    t.string "name"
    t.string "genre"
    t.string "artist"
    t.string "tracks"
    t.string "self"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "artist_id"
    t.index ["artist_id"], name: "index_albums_on_artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "id_artist"
    t.string "name"
    t.integer "age"
    t.string "albums"
    t.string "tracks"
    t.string "self"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string "id_track"
    t.string "name"
    t.float "duration"
    t.integer "times_played"
    t.string "artist"
    t.string "album"
    t.string "self"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "album_id"
    t.index ["album_id"], name: "index_tracks_on_album_id"
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "tracks", "albums"
end
