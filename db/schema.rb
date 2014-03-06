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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131105201228) do

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.string   "caption"
    t.string   "coverpage"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "owner"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "filepath"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
    t.integer  "owner"
  end

  create_table "datafiles", :force => true do |t|
    t.string   "filepath"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "owner"
    t.string   "title"
  end

  create_table "emails", :force => true do |t|
    t.string   "email_from"
    t.string   "email_to"
    t.string   "email_subject"
    t.string   "email_cc"
    t.string   "email_bcc"
    t.text     "email_body"
    t.string   "email_attachment"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "visited"
  end

  create_table "eventcomments", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "location"
    t.datetime "starttime"
    t.datetime "endtime"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "street_address"
    t.string   "city_address"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "country"
    t.string   "email"
    t.string   "phone_number"
    t.string   "event_type"
    t.integer  "owner"
  end

  create_table "expcomments", :force => true do |t|
    t.integer  "exp_id"
    t.integer  "owner"
    t.text     "description"
    t.integer  "no_of_views"
    t.string   "comment_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "experiences", :force => true do |t|
    t.string   "topic"
    t.integer  "owner"
    t.text     "description"
    t.integer  "no_of_views"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "magazines", :force => true do |t|
    t.string   "title"
    t.string   "filepath"
    t.string   "coverpageimage"
    t.string   "languagewritten"
    t.date     "datewritten"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "month"
    t.integer  "year"
    t.integer  "owner"
  end

  create_table "models", :force => true do |t|
    t.string   "album"
    t.string   "title"
    t.string   "caption"
    t.string   "coverpage"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "title"
    t.string   "caption"
    t.integer  "album_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "owner"
  end

  create_table "practices", :force => true do |t|
    t.datetime "date"
    t.integer  "course_id"
    t.integer  "course_from_number"
    t.integer  "course_to_number"
    t.integer  "user_id"
    t.string   "experience"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "guide_id"
    t.integer  "owner"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "schedules", :force => true do |t|
    t.integer  "event_id"
    t.string   "title"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "next_event"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "date"
  end

  create_table "usercourses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "no_of_names_per_day"
    t.integer  "guide_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.date     "date"
    t.integer  "course_no_from"
    t.integer  "course_no_to"
    t.text     "user_experiences"
    t.string   "practice_type"
    t.datetime "practice_start_date"
    t.integer  "practice_time"
    t.integer  "rest_time"
    t.string   "status"
  end

  create_table "userroles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.string   "assigned_by"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "guide_id"
    t.string   "group_leader"
  end

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.datetime "date_of_birth"
    t.string   "street_address"
    t.string   "city_address"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "country"
    t.string   "email"
    t.string   "phone_number"
    t.string   "photo"
    t.string   "voice_request"
    t.string   "salt"
    t.string   "terms_accepted"
    t.string   "confirm_password"
    t.datetime "last_succ_login"
    t.boolean  "email_subscriber"
  end

end
