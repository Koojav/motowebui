class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.string      :name
      t.references  :result, foreign_key: true, null: false, default: 1
      t.datetime    :start_time
      t.integer     :duration, default: 0
      t.text        :error_message
      t.text        :fail_message
      t.string      :ticket_url
      t.string      :tags
      t.references  :run, foreign_key: true
    end
  end
end
