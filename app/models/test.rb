class Test < ApplicationRecord
  belongs_to :directory
  belongs_to :result
  has_one    :log
  belongs_to :tester

  # after_commit :mark_tree_as_dirty

  def display_duration
    Time.at(duration).utc.strftime('%H:%M:%S')
  end

  def display_name(max_length = 140)
    length = name.length
    excess = length - (max_length + 3)

    if excess > 0
      return name[0..((length - excess)/2)] + '...' + name[((length + excess)/2)..length]
    end

    name
  end

  def self.create_uniq_in_dir(tests_data, directory_id)
    updated_tests = []
    created_tests = []
    create_data = []

    tests_data.each do |test_data|
      test = Test.find_by(directory_id: directory_id, name: test_data[:name].downcase)

      # Update if exists
      if test
        updated_tests << test.update(test_data)
      # or add to a collection which will be used to create all new at the same time
      else
        test_data[:directory_id] = directory_id
        create_data << test_data
      end

    end

    if !create_data.empty?
      created_tests = Test.create(create_data)
    end

    created_tests + updated_tests
  end

  # Mark Directory tree as dirty whenever a child Test has been modified
  # so when a Directory is selected next time it and its children can be validated just once
  # with new values based composed from Tests' ones.
  # def mark_tree_as_dirty
  #   # Invoked via pure SQL, not via ORM, in order to avoid triggering callbacks in
  #   sql = "UPDATE directories SET stats_dirty=1 WHERE directories.id IN [#{...}];"
  #   ActiveRecord::Base.connection.execute(sql)
  # end
end
