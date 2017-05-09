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

ActiveRecord::Schema.define(version: 20170508162849) do

  create_table "scale_caches", force: :cascade do |t|
    t.string "interval_sequence"
    t.string "tone"
  end

  create_table "chord_caches", force: :cascade do |t|
    t.string "name"
    t.integer "size"
  end

  create_table "scale_chords", force: :cascade do |t|
    t.integer "scale_cache_id"
    t.integer "chord_cache_id"
  end

end
