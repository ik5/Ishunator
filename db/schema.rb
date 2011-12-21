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

ActiveRecord::Schema.define(:version => 20111219192212) do

  create_table "business_types", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "complaints", :force => true do |t|
    t.integer  "city_id",                                                          :null => false
    t.date     "event_date",                                                       :null => false
    t.string   "business_type_other"
    t.string   "business_name",                                                    :null => false
    t.string   "business_address",                                                 :null => false
    t.boolean  "smoking_person",                                :default => false, :null => false
    t.boolean  "smoking_ashtrays",                              :default => false, :null => false
    t.string   "smoking_ashtrays_details"
    t.boolean  "smoking_room_not_seperate",                     :default => false, :null => false
    t.boolean  "smoking_room_too_large",                        :default => false, :null => false
    t.boolean  "smoking_room_must_pass_through_to_public_area", :default => false, :null => false
    t.boolean  "smoking_room_must_pass_through_to_bathroom",    :default => false, :null => false
    t.string   "smoking_room_must_pass_through_to_other"
    t.boolean  "smoking_room_not_closed",                       :default => false, :null => false
    t.string   "smoking_room_smoking_outside_details"
    t.boolean  "smoking_no_signs",                              :default => false, :null => false
    t.boolean  "smoking_signs_too_small",                       :default => false, :null => false
    t.boolean  "smoking_signs_not_at_height",                   :default => false, :null => false
    t.string   "smoking_signs_hidden_details"
    t.string   "complaint_sender_name"
    t.string   "statement_full_name"
    t.string   "statement_address"
    t.string   "statement_phone"
    t.string   "statement_email"
    t.integer  "statement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_type_id",                                                 :null => false
  end

  add_index "complaints", ["business_type_id"], :name => "index_complaints_on_business_type_id"
  add_index "complaints", ["city_id"], :name => "index_complaints_on_city_id"

end
