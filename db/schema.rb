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

ActiveRecord::Schema.define(version: 20161111114000) do

  create_table "directories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text    "path",      limit: 65535,             null: false
    t.string  "name",                                null: false
    t.integer "parent_id"
    t.integer "tester_id",               default: 1
    t.index ["name"], name: "index_directories_on_name", using: :btree
    t.index ["parent_id"], name: "index_directories_on_parent_id", using: :btree
    t.index ["tester_id"], name: "index_directories_on_tester_id", using: :btree
  end

  create_table "logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text    "text",    limit: 4294967295
    t.integer "test_id"
    t.index ["test_id"], name: "index_logs_on_test_id", using: :btree
  end

  create_table "results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "name"
    t.boolean "manual",   default: false
    t.string  "category", default: "PASS"
  end

  create_table "testers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.index ["name"], name: "index_testers_on_name", unique: true, using: :btree
  end

  create_table "tests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "result_id",                   default: 1, null: false
    t.integer  "tester_id",                   default: 1
    t.integer  "directory_id"
    t.datetime "start_time"
    t.integer  "duration",                    default: 0
    t.text     "error_message", limit: 65535
    t.text     "fail_message",  limit: 65535
    t.text     "ticket_urls",   limit: 65535
    t.string   "tags"
    t.text     "description",   limit: 65535
    t.index ["directory_id"], name: "index_tests_on_directory_id", using: :btree
    t.index ["name"], name: "index_tests_on_name", using: :btree
    t.index ["result_id"], name: "index_tests_on_result_id", using: :btree
    t.index ["tester_id"], name: "index_tests_on_tester_id", using: :btree
  end

  add_foreign_key "directories", "directories", column: "parent_id", on_delete: :cascade
  add_foreign_key "directories", "testers"
  add_foreign_key "logs", "tests", on_delete: :cascade
  add_foreign_key "tests", "directories", on_delete: :cascade
  add_foreign_key "tests", "results"
  add_foreign_key "tests", "testers"
end
