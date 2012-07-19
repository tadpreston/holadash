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

ActiveRecord::Schema.define(:version => 20120716021026) do

  create_table "club_users", :force => true do |t|
    t.integer  "club_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.text     "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "envelopes", :force => true do |t|
    t.integer  "message_id"
    t.integer  "recipient_id"
    t.boolean  "read_flag",    :default => false
    t.boolean  "trash_flag",   :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "author_flag",  :default => false
  end

  add_index "envelopes", ["message_id"], :name => "index_envelopes_on_message_id"
  add_index "envelopes", ["recipient_id"], :name => "index_envelopes_on_recipient_id"

  create_table "messages", :force => true do |t|
    t.integer  "author_id"
    t.string   "send_to"
    t.string   "copy_to"
    t.string   "blind_copy_to"
    t.string   "subject"
    t.text     "body"
    t.string   "status",        :default => "draft"
    t.string   "importance",    :default => "normal"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.datetime "sent_at"
  end

  add_index "messages", ["author_id"], :name => "index_messages_on_author_id"
  add_index "messages", ["sent_at"], :name => "index_messages_on_sent_at"
  add_index "messages", ["subject"], :name => "index_messages_on_subject"

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sys_logs", :force => true do |t|
    t.text     "message"
    t.string   "message_type"
    t.string   "actioned_by"
    t.integer  "loggable_id"
    t.string   "loggable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "sys_logs", ["loggable_id", "loggable_type"], :name => "index_sys_logs_on_loggable_id_and_loggable_type"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "roles"
    t.string   "employee_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "auth_token"
    t.string   "display_name"
  end

  add_index "users", ["display_name"], :name => "index_users_on_display_name"
  add_index "users", ["employee_id"], :name => "index_users_on_employee_id"
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["username"], :name => "index_users_on_username"

end
