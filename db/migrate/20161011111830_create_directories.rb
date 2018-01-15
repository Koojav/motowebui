class CreateDirectories < ActiveRecord::Migration[5.0]
  def change

    create_table :directories do |t|
      t.string :path, null: false
      t.references :parent, index: true, foreign_key: { to_table: :directories, on_delete: :cascade }
    end

  end
end
