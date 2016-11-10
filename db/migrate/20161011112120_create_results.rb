class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.string  :name
      t.boolean :manual, default: false
      t.string  :category, default: 'PASS'
    end
  end
end
