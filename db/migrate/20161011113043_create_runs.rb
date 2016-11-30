class CreateRuns < ActiveRecord::Migration[5.0]

  def change
    create_table :runs do |t|
      t.string      :name
      t.references  :tester, foreign_key: true, default: 1
      t.datetime    :start_time
      t.integer     :duration, default: 0
      t.references  :suite, foreign_key: true
      t.boolean     :stats_dirty, default: false
      t.integer     :stats_tests_all,     default: 0
      t.integer     :stats_tests_pass,    default: 0
      t.integer     :stats_tests_error,   default: 0
      t.integer     :stats_tests_fail,    default: 0
      t.integer     :stats_tests_skip,    default: 0
      t.integer     :stats_tests_running, default: 0
    end
  end
end
