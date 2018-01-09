class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.string      :name
      t.references  :result, foreign_key: true, null: false, default: 1
      t.datetime    :start_time
      t.integer     :duration, default: 0
      t.text        :error_message
      t.text        :fail_message
      t.text        :ticket_urls
      t.string      :tags
      t.text        :description
      t.references  :directory, foreign_key: {on_delete: :cascade}
    end
  end
end
