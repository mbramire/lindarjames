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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20140330190731) do
=======
ActiveRecord::Schema.define(version: 20140331183410) do
>>>>>>> 4efaec1e44679b6f67682c7f4a5101293f0d07f2

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

<<<<<<< HEAD
=======
  create_table "documents", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "doc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

>>>>>>> 4efaec1e44679b6f67682c7f4a5101293f0d07f2
  create_table "gallery_images", force: true do |t|
    t.string   "title"
    t.string   "image"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
<<<<<<< HEAD
=======
    t.string   "medium"
    t.string   "scale"
    t.string   "date"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
>>>>>>> 4efaec1e44679b6f67682c7f4a5101293f0d07f2
  end

end
