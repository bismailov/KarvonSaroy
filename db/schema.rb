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

ActiveRecord::Schema.define(:version => 20131022082537) do

  create_table "courses", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "subject_id"
    t.integer  "student_level_id"
    t.text     "objectives"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "courses", ["title"], :name => "index_courses_on_title", :unique => true
  add_index "courses", ["user_id"], :name => "index_courses_on_user_id"

  create_table "lessons", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "media_file"
    t.integer  "course_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "video_attachment_file_name"
    t.string   "video_attachment_content_type"
    t.integer  "video_attachment_file_size"
    t.datetime "video_attachment_updated_at"
  end

  add_index "lessons", ["course_id"], :name => "index_lessons_on_course_id"
  add_index "lessons", ["title"], :name => "index_lessons_on_title", :unique => true

  create_table "student_levels", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "student_levels", ["title"], :name => "index_student_levels_on_title", :unique => true

  create_table "subjects", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "subjects", ["title"], :name => "index_subjects_on_title", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "surname"
    t.string   "remember_token"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
