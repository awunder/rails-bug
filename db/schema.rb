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

ActiveRecord::Schema.define(version: 20170327164441) do

  create_table "achievements", force: :cascade do |t|
    t.string   "name"
    t.text     "additional_info"
    t.datetime "due_date"
    t.integer  "achievementable_id"
    t.string   "achievementable_type"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "media"
    t.string   "rollout"
    t.datetime "ready"
    t.boolean  "visible",              default: false
    t.integer  "domain_rank",          default: 9999
    t.integer  "action_field_rank",    default: 9999
  end

  create_table "action_fields", force: :cascade do |t|
    t.string   "name"
    t.string   "target"
    t.integer  "solution",      default: 0
    t.integer  "skills",        default: 0
    t.integer  "organization",  default: 0
    t.float    "domain_weight", default: 1.0
    t.integer  "domain_id"
    t.integer  "editor_id"
    t.integer  "deputy_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["deputy_id"], name: "index_action_fields_on_deputy_id"
    t.index ["domain_id"], name: "index_action_fields_on_domain_id"
    t.index ["editor_id"], name: "index_action_fields_on_editor_id"
  end

  create_table "actions", force: :cascade do |t|
    t.string   "name"
    t.text     "additional_info"
    t.datetime "due_date"
    t.string   "rollout"
    t.integer  "actionable_id"
    t.string   "actionable_type"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "visible",           default: false
    t.integer  "domain_rank",       default: 9999
    t.integer  "action_field_rank", default: 9999
    t.index ["actionable_id", "actionable_type"], name: "index_actions_on_actionable_id_and_actionable_type"
  end

  create_table "domains", force: :cascade do |t|
    t.string   "name"
    t.integer  "adjust_solution",      default: 0
    t.integer  "adjust_skills",        default: 0
    t.integer  "adjust_organization",  default: 0
    t.integer  "editor_id"
    t.integer  "deputy_id"
    t.integer  "solution_category_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["deputy_id"], name: "index_domains_on_deputy_id"
    t.index ["editor_id"], name: "index_domains_on_editor_id"
    t.index ["solution_category_id"], name: "index_domains_on_solution_category_id"
  end

end
