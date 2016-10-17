class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.string :name
      t.references :result, foreign_key: true
      t.text :log
      t.text :notes
      t.date :start_time
      t.date :end_time
      t.references :run, foreign_key: true

      t.timestamps
    end
  end
end
