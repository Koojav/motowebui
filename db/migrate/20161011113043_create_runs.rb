class CreateRuns < ActiveRecord::Migration[5.0]
  def change
    create_table :runs do |t|
      t.string :name
      t.references :tester, foreign_key: true
      t.references :result, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.references :suite, foreign_key: true
    end
  end
end
