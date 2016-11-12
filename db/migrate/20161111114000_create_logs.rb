class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.text        :text
      t.references  :test, foreign_key: true
    end
  end
end
