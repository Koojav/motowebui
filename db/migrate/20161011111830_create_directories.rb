class CreateDirectories < ActiveRecord::Migration[5.0]
  def change

    create_table :directories do |t|
      t.text        :path, limit: 4096, null: false
      t.string      :name, null: false
      t.references  :parent, index: true, foreign_key: { to_table: :directories, on_delete: :cascade }
      t.references  :tester, foreign_key: true, default: 1

      # Might be needed in the future in order to optimize reporting
      # For now reports are on separate view, on request only, shouldn't pose much threat to performance

      # t.boolean     :stats_dirty, default: false
      # t.integer     :stats_tests_all,     default: 0
      # t.integer     :stats_tests_pass,    default: 0
      # t.integer     :stats_tests_error,   default: 0
      # t.integer     :stats_tests_fail,    default: 0
      # t.integer     :stats_tests_skip,    default: 0
      # t.integer     :stats_tests_running, default: 0
    end

  end
end
