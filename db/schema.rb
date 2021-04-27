# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_17_061223) do

  create_table "buildings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "total_floor"
    t.integer "full_room_quantity", default: 0
    t.integer "unfilled_room_quantity", default: 0
    t.integer "pending_room_quantity", default: 0
    t.boolean "has_problem", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "complaint_reports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", size: :long, null: false
    t.string "status", default: "PENDING", null: false
    t.integer "index", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "student_id", null: false
    t.text "reject_reason", size: :long
    t.index ["student_id"], name: "index_complaint_reports_on_student_id"
  end

  create_table "facilities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "quantity", default: 1, null: false
    t.string "status", default: "NEW", null: false
    t.string "detail"
    t.string "images"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "room_id", null: false
    t.index ["room_id"], name: "index_facilities_on_room_id"
  end

  create_table "facility_reports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", size: :long, null: false
    t.string "status", default: "PENDING", null: false
    t.integer "index", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "student_id", null: false
    t.text "reject_reason", size: :long
    t.index ["student_id"], name: "index_facility_reports_on_student_id"
  end

  create_table "form_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "form_type", null: false
    t.text "description", size: :long, null: false
    t.string "status", default: "PENDING", null: false
    t.integer "index", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "student_id", null: false
    t.datetime "return_date"
    t.text "note", size: :long
    t.index ["student_id"], name: "index_form_requests_on_student_id"
  end

  create_table "managers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "channel"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_managers_on_email", unique: true
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "message", null: false
    t.integer "sender_id", null: false
    t.integer "receiver_id", null: false
    t.string "sender_type", null: false
    t.string "receiver_type", null: false
    t.boolean "is_read", default: false, null: false
    t.integer "page"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "noti_type", null: false
    t.integer "report_id"
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "order_id"
    t.string "payer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "content", size: :long
    t.string "writer_name"
    t.bigint "manager_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.json "images"
    t.index ["manager_id"], name: "index_posts_on_manager_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "room_name", null: false
    t.integer "number_student", default: 0, null: false
    t.integer "max_number_student", null: false
    t.string "room_type", null: false
    t.integer "floor", default: 0, null: false
    t.boolean "has_problem", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status", default: "PENDING"
    t.string "gender"
    t.bigint "building_id", null: false
    t.index ["building_id"], name: "index_rooms_on_building_id"
    t.index ["room_name"], name: "index_rooms_on_room_name", unique: true
  end

  create_table "service_charges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "water_price", default: 0, null: false
    t.integer "electricity_price", default: 0, null: false
    t.integer "total_price", default: 0, null: false
    t.string "status", default: "UNPAID", null: false
    t.integer "month", null: false
    t.integer "year", null: false
    t.string "payer"
    t.datetime "paid_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "room_id", null: false
    t.index ["room_id"], name: "index_service_charges_on_room_id"
  end

  create_table "student_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "class_name"
    t.string "name", null: false
    t.datetime "date_of_birth"
    t.string "identity_card_number"
    t.string "address"
    t.string "phone_number"
    t.string "gender"
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "student_id", null: false
    t.index ["email"], name: "index_student_profiles_on_email", unique: true
    t.index ["student_id"], name: "index_student_profiles_on_student_id"
  end

  create_table "students", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "student_id_number", null: false
    t.string "name", null: false
    t.datetime "check_in_date"
    t.datetime "check_out_date"
    t.integer "extended_time", default: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "room_id", default: 1, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "status", default: "PENDING"
    t.string "channel"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["room_id"], name: "index_students_on_room_id"
    t.index ["student_id_number"], name: "index_students_on_student_id_number", unique: true
  end

  add_foreign_key "complaint_reports", "students"
  add_foreign_key "facilities", "rooms"
  add_foreign_key "facility_reports", "students"
  add_foreign_key "form_requests", "students"
  add_foreign_key "posts", "managers"
  add_foreign_key "rooms", "buildings"
  add_foreign_key "service_charges", "rooms"
  add_foreign_key "student_profiles", "students"
  add_foreign_key "students", "rooms"
end
