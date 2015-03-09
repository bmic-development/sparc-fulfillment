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

ActiveRecord::Schema.define(version: 20150309145731) do

  create_table "appointments", force: true do |t|
    t.integer  "participant_id"
    t.integer  "visit_group_id"
    t.integer  "visit_group_position"
    t.integer  "position"
    t.string   "name"
    t.datetime "start_date"
    t.datetime "completed_date"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "arms", force: true do |t|
    t.integer  "sparc_id"
    t.integer  "protocol_id"
    t.string   "name"
    t.integer  "visit_count"
    t.integer  "subject_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "arms", ["deleted_at"], name: "index_arms_on_deleted_at", using: :btree
  add_index "arms", ["protocol_id"], name: "index_arms_on_protocol_id", using: :btree
  add_index "arms", ["sparc_id"], name: "index_arms_on_sparc_id", unique: true, using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "line_items", force: true do |t|
    t.integer  "sparc_id"
    t.integer  "arm_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "subject_count"
  end

  add_index "line_items", ["arm_id"], name: "index_line_items_on_arm_id", using: :btree
  add_index "line_items", ["deleted_at"], name: "index_line_items_on_deleted_at", using: :btree
  add_index "line_items", ["service_id"], name: "index_line_items_on_service_id", using: :btree
  add_index "line_items", ["sparc_id"], name: "index_line_items_on_sparc_id", unique: true, using: :btree

  create_table "notes", force: true do |t|
    t.integer  "procedure_id"
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "comment"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "sparc_id"
    t.string   "action"
    t.string   "callback_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kind"
  end

  add_index "notifications", ["sparc_id"], name: "index_notifications_on_sparc_id", using: :btree

  create_table "participants", force: true do |t|
    t.integer  "protocol_id"
    t.integer  "arm_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "mrn"
    t.string   "status"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "race"
    t.string   "address"
    t.string   "phone"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_cost"
    t.string   "recruitment_source"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
  end

  add_index "participants", ["arm_id"], name: "index_participants_on_arm_id", using: :btree
  add_index "participants", ["deleted_at"], name: "index_participants_on_deleted_at", using: :btree
  add_index "participants", ["protocol_id"], name: "index_participants_on_protocol_id", using: :btree

  create_table "procedures", force: true do |t|
    t.integer  "appointment_id"
    t.string   "service_name"
    t.integer  "service_cost"
    t.integer  "service_id"
    t.string   "status"
    t.datetime "start_date"
    t.datetime "completed_date"
    t.string   "billing_type"
    t.string   "reason"
    t.datetime "follow_up_date"
    t.integer  "sparc_core_id"
    t.string   "sparc_core_name"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_id"
  end

  add_index "procedures", ["appointment_id"], name: "index_procedures_on_appointment_id", using: :btree
  add_index "procedures", ["completed_date"], name: "index_procedures_on_completed_date", using: :btree
  add_index "procedures", ["service_id"], name: "index_procedures_on_service_id", using: :btree
  add_index "procedures", ["visit_id"], name: "index_procedures_on_visit_id", using: :btree

  create_table "protocols", force: true do |t|
    t.integer  "sparc_id"
    t.text     "title"
    t.string   "short_title"
    t.string   "sponsor_name"
    t.string   "udak_project_number"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "recruitment_start_date"
    t.datetime "recruitment_end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "irb_status"
    t.datetime "irb_approval_date"
    t.datetime "irb_expiration_date"
    t.float    "stored_percent_subsidy",       limit: 24
    t.integer  "study_cost"
    t.integer  "sparc_sub_service_request_id"
    t.string   "status"
  end

  add_index "protocols", ["deleted_at"], name: "index_protocols_on_deleted_at", using: :btree
  add_index "protocols", ["sparc_id"], name: "index_protocols_on_sparc_id", unique: true, using: :btree

  create_table "services", force: true do |t|
    t.integer  "sparc_id"
    t.decimal  "cost",            precision: 10, scale: 0
    t.string   "name"
    t.string   "abbreviation"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "sparc_core_id"
    t.string   "sparc_core_name"
  end

  add_index "services", ["deleted_at"], name: "index_services_on_deleted_at", using: :btree
  add_index "services", ["sparc_id"], name: "index_services_on_sparc_id", unique: true, using: :btree

  create_table "tasks", force: true do |t|
    t.string   "participant_name"
    t.string   "created_by"
    t.integer  "protocol_id"
    t.string   "visit_name"
    t.string   "arm_name"
    t.string   "task"
    t.string   "assignment"
    t.date     "due_date"
    t.boolean  "is_complete"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "task_type"
  end

  create_table "user_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "protocol_id"
    t.string   "rights"
    t.string   "role"
    t.string   "role_other"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "user_roles", ["protocol_id"], name: "index_user_roles_on_protocol_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",                           null: false
    t.string   "encrypted_password",     default: "",                           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "time_zone",              default: "Eastern Time (US & Canada)"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visit_groups", force: true do |t|
    t.integer  "sparc_id"
    t.integer  "arm_id"
    t.integer  "position"
    t.string   "name"
    t.integer  "day"
    t.integer  "window_before"
    t.integer  "window_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "visit_groups", ["arm_id"], name: "index_visit_groups_on_arm_id", using: :btree
  add_index "visit_groups", ["deleted_at"], name: "index_visit_groups_on_deleted_at", using: :btree
  add_index "visit_groups", ["position"], name: "index_visit_groups_on_position", using: :btree
  add_index "visit_groups", ["sparc_id"], name: "index_visit_groups_on_sparc_id", unique: true, using: :btree

  create_table "visits", force: true do |t|
    t.integer  "sparc_id"
    t.integer  "line_item_id"
    t.integer  "visit_group_id"
    t.integer  "research_billing_qty"
    t.integer  "insurance_billing_qty"
    t.integer  "effort_billing_qty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "visits", ["deleted_at"], name: "index_visits_on_deleted_at", using: :btree
  add_index "visits", ["line_item_id"], name: "index_visits_on_line_item_id", using: :btree
  add_index "visits", ["sparc_id"], name: "index_visits_on_sparc_id", unique: true, using: :btree
  add_index "visits", ["visit_group_id"], name: "index_visits_on_visit_group_id", using: :btree

end
