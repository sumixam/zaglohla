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

ActiveRecord::Schema.define(version: 20140525190931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_ctos", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "adress_street"
    t.string   "adress_buildng"
    t.string   "adress_additional"
    t.string   "site"
    t.string   "email"
    t.boolean  "gov_certificate"
    t.boolean  "manufacture_certificate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "password"
    t.integer  "city_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administrators", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "acl",                    default: 0
  end

  add_index "administrators", ["email"], name: "index_administrators_on_email", unique: true, using: :btree
  add_index "administrators", ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true, using: :btree

  create_table "answers", force: true do |t|
    t.text     "body"
    t.integer  "question_id"
    t.integer  "user_id"
    t.boolean  "email_notification"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_brand_category_autos", force: true do |t|
    t.integer  "car_brand_id"
    t.integer  "category_auto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_brands", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "foreigh_type"
    t.boolean  "local_brand"
    t.string   "slug"
    t.boolean  "fav"
  end

  create_table "car_engines", force: true do |t|
    t.string   "name"
    t.integer  "car_generation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "car_engines", ["car_generation_id"], name: "index_car_engines_on_car_generation_id", using: :btree

  create_table "car_generations", force: true do |t|
    t.string   "name"
    t.integer  "car_model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "start"
    t.integer  "ends"
  end

  add_index "car_generations", ["car_model_id"], name: "index_car_generations_on_car_model_id", using: :btree

  create_table "car_models", force: true do |t|
    t.string   "name"
    t.integer  "car_brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "car_models", ["car_brand_id"], name: "index_car_models_on_car_brand_id", using: :btree

  create_table "cars", force: true do |t|
    t.integer  "user_id"
    t.string   "category_type"
    t.integer  "car_engine_id"
    t.string   "year"
    t.string   "vin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "text"
    t.string   "nick"
    t.integer  "year_start"
    t.integer  "car_generation_id"
    t.integer  "car_model_id"
    t.integer  "car_brand_id"
  end

  create_table "category_autos", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "control_programms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cto_car_brands", force: true do |t|
    t.integer  "cto_id"
    t.integer  "car_brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cto_category_autos", force: true do |t|
    t.integer  "cto_id"
    t.integer  "category_auto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cto_control_programms", force: true do |t|
    t.integer  "cto_id"
    t.integer  "control_programm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cto_districts", force: true do |t|
    t.integer  "cto_id"
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cto_job_types", force: true do |t|
    t.integer  "cto_id"
    t.integer  "job_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cto_metro_stations", force: true do |t|
    t.integer  "cto_id"
    t.integer  "metro_station_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cto_sales", force: true do |t|
    t.string   "description"
    t.string   "salable_type"
    t.integer  "salable_id"
    t.integer  "cto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cto_services", force: true do |t|
    t.integer  "cto_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ctos", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.string   "adress_street"
    t.string   "adress_buildng"
    t.string   "adress_additional"
    t.string   "site"
    t.string   "email"
    t.string   "icq"
    t.string   "skype"
    t.string   "vk_link"
    t.string   "work_time"
    t.text     "description"
    t.boolean  "gov_certificate"
    t.boolean  "manufacture_certificate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "phone"
    t.string   "additional_phone_1"
    t.string   "additional_phone_2"
    t.string   "additional_phone_3"
    t.string   "other_job_types"
    t.string   "manufacture_certificate_list"
    t.string   "guarantee"
    t.boolean  "sign_on_time"
    t.string   "boxsize"
    t.string   "sale_percent"
    t.string   "sale_comment"
    t.string   "contact_person"
    t.integer  "intresting_to_work"
    t.string   "other_control_programm"
    t.boolean  "payment_cash"
    t.boolean  "payment_card"
    t.boolean  "payment_bill"
    t.boolean  "show_on_site"
    t.integer  "start_from_year"
    t.integer  "administrator_id"
    t.string   "vk_page"
    t.string   "adress_comment"
    t.boolean  "official_diler"
    t.string   "lat"
    t.string   "lon"
    t.boolean  "work_with_other_brands"
  end

  create_table "districts", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "is_city"
  end

  create_table "equipment_ctos", force: true do |t|
    t.string   "title"
    t.integer  "cto_id"
    t.string   "mark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guarantee_ctos", force: true do |t|
    t.integer  "cto_id"
    t.string   "length"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "manufacture_certs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mechanic_user_car_brands", force: true do |t|
    t.integer  "user_id"
    t.integer  "car_brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mechanic_user_job_types", force: true do |t|
    t.integer  "user_id"
    t.integer  "job_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mechanic_user_sub_job_types", force: true do |t|
    t.integer  "user_id"
    t.integer  "sub_job_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metro_stations", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "pages", force: true do |t|
    t.integer  "parent_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible"
  end

  create_table "pay_per_hours", force: true do |t|
    t.string   "category_type"
    t.integer  "car_engine_id"
    t.integer  "work_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cto_id"
  end

  create_table "photos", force: true do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.boolean  "main"
  end

  create_table "questions", force: true do |t|
    t.string   "topic"
    t.text     "body"
    t.boolean  "email_notification"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "car_engine_id"
    t.boolean  "visible"
    t.integer  "car_brand_id"
    t.integer  "car_model_id"
    t.integer  "car_generation_id"
  end

  create_table "rates", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "repair_costs", force: true do |t|
    t.integer  "repair_work_type_id"
    t.integer  "repair_work_sector_id"
    t.integer  "car_generation_id"
    t.integer  "car_engine_id"
    t.integer  "car_model_id"
    t.integer  "car_brand_id"
    t.float    "hours"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "repair_work_job_id"
  end

  add_index "repair_costs", ["car_engine_id", "repair_work_job_id", "repair_work_type_id", "repair_work_sector_id", "car_generation_id", "car_model_id", "car_brand_id"], name: "full_index_fields", using: :btree
  add_index "repair_costs", ["car_engine_id", "repair_work_job_id"], name: "index_repair_costs_on_car_engine_id_and_repair_work_job_id", using: :btree
  add_index "repair_costs", ["car_engine_id"], name: "index_repair_costs_on_car_engine_id", using: :btree
  add_index "repair_costs", ["repair_work_job_id"], name: "index_repair_costs_on_repair_work_job_id", using: :btree

  create_table "repair_requests", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "email"
    t.string   "phone"
    t.string   "name"
    t.integer  "car_engine_id"
    t.integer  "car_generation_id"
    t.integer  "car_model_id"
    t.integer  "car_brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "proccessed"
  end

  create_table "repair_work_jobs", force: true do |t|
    t.string   "name"
    t.integer  "repair_work_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repair_work_jobs", ["repair_work_type_id"], name: "index_repair_work_jobs_on_repair_work_type_id", using: :btree

  create_table "repair_work_sectors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repair_work_types", force: true do |t|
    t.string   "name"
    t.integer  "repair_work_sector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repair_work_types", ["repair_work_sector_id"], name: "index_repair_work_types_on_repair_work_sector_id", using: :btree

  create_table "services", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spare_queries", force: true do |t|
    t.string   "term"
    t.integer  "attempts",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spares", force: true do |t|
    t.string   "manufacture"
    t.string   "number"
    t.string   "title"
    t.integer  "price"
    t.string   "seller"
    t.string   "avalaible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_job_type_ctos", force: true do |t|
    t.integer  "sub_job_type_id"
    t.integer  "cto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_job_types", force: true do |t|
    t.string   "name"
    t.integer  "job_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_cto_favs", force: true do |t|
    t.integer  "user_id"
    t.integer  "cto_fav_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_levels", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_thanks", force: true do |t|
    t.integer  "user_id"
    t.integer  "thank_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "phone"
    t.integer  "city_id"
    t.integer  "level_state_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "type",                   default: "CarOwner"
    t.float    "rating"
    t.integer  "cto_id"
    t.integer  "start_career_year"
    t.string   "facebook_id"
    t.string   "vk_id"
    t.integer  "user_level_id"
    t.text     "description"
    t.boolean  "notify_news",            default: true
    t.boolean  "notify_answers",         default: true
    t.boolean  "notify_questions",       default: true
    t.boolean  "notify_responses",       default: true
    t.integer  "mechanic_cto_id"
    t.boolean  "mechanic_cto_confirmed"
    t.integer  "owner_cto_id"
    t.boolean  "owner_cto_confirmed"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "work_hours", force: true do |t|
    t.string   "weekday_start"
    t.string   "time_start"
    t.string   "weekday_finish"
    t.string   "time_finish"
    t.integer  "cto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
