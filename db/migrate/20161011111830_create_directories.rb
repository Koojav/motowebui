class CreateDirectories < ActiveRecord::Migration[5.0]
  def change

    create_table :directories do |t|
      t.string :path, null: false
      t.references :directory, foreign_key: {on_delete: :cascade}
    end

  end
end
