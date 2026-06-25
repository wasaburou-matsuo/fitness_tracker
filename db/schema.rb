# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_06_25_083003) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "body_part"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "name"], name: "index_exercises_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "gyms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "name"], name: "index_gyms_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_gyms_on_user_id"
  end

  create_table "machines", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "gym_id", null: false
    t.string "name", null: false
    t.text "setting_memo"
    t.datetime "updated_at", null: false
    t.index ["gym_id", "name"], name: "index_machines_on_gym_id_and_name", unique: true
    t.index ["gym_id"], name: "index_machines_on_gym_id"
  end

  create_table "training_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "exercise_id", null: false
    t.bigint "machine_id"
    t.text "memo"
    t.date "trained_on", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index "user_id, exercise_id, COALESCE(machine_id, (0)::bigint), trained_on", name: "index_training_sessions_unique", unique: true
    t.index ["exercise_id"], name: "index_training_sessions_on_exercise_id"
    t.index ["machine_id"], name: "index_training_sessions_on_machine_id"
    t.index ["user_id"], name: "index_training_sessions_on_user_id"
  end

  create_table "training_sets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "reps", null: false
    t.integer "set_number", null: false
    t.bigint "training_session_id", null: false
    t.datetime "updated_at", null: false
    t.decimal "weight", precision: 5, scale: 2, null: false
    t.index ["training_session_id", "set_number"], name: "index_training_sets_on_training_session_id_and_set_number", unique: true
    t.index ["training_session_id"], name: "index_training_sets_on_training_session_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "exercises", "users"
  add_foreign_key "gyms", "users"
  add_foreign_key "machines", "gyms"
  add_foreign_key "training_sessions", "exercises"
  add_foreign_key "training_sessions", "machines"
  add_foreign_key "training_sessions", "users"
  add_foreign_key "training_sets", "training_sessions"
end
