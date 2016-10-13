class CreateTesters < ActiveRecord::Migration[5.0]
  def change
    create_table :testers do |t|
      t.string :name

      t.timestamps
    end
  end
end
