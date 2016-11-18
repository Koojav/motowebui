class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.text        :text, limit: 4294967295
      t.references  :test, foreign_key: true
    end
  end
end
