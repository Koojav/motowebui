class CreateTestRuns < ActiveRecord::Migration[5.0]
  def change
    create_table :test_runs do |t|
      t.string :name
      t.references :tester, foreign_key: true
      t.references :result, foreign_key: true
      t.date :start_time
      t.date :end_time
      t.references :test_suite, foreign_key: true

      t.timestamps
    end
  end
end
