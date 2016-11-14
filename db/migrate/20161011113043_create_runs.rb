class CreateRuns < ActiveRecord::Migration[5.0]

  def change
    create_table :runs do |t|
      t.string      :name
      t.references  :tester, foreign_key: true, default: 1
      t.references  :result, foreign_key: true, default: 1
      t.datetime    :start_time
      t.integer     :duration, default: 0
      t.references  :suite, foreign_key: true
      t.boolean     :result_dirty, default: false
    end
  end
end
