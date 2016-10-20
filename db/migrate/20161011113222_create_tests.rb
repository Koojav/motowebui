class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.string      :name
      t.references  :result, foreign_key: true, null: false, default: 1
      t.text        :log
      t.text        :notes
      t.datetime    :start_time
      t.datetime    :end_time
      t.references :run, foreign_key: true
    end
  end
end
