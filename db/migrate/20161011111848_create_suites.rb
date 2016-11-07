class CreateSuites < ActiveRecord::Migration[5.0]
  def change
    create_table :suites do |t|
      t.string :name, null: false
    end

    add_index :suites, :name, unique: true

  end
end
