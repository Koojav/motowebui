class Directory < ApplicationRecord
  has_many :directories
  has_many :tests
  belongs_to :tester

  def subdirectories
    Directory.where(parent_id: id)
  end

  def navigation_path
    if !@navigation_path
      @navigation_path = []
      directory = self

      @navigation_path << directory

      while directory.parent_id
        directory = Directory.find(directory.parent_id)
        @navigation_path << directory
      end

      @navigation_path
    end

    @navigation_path
  end

  def self.create_tree(path, standardize_path = true)
    # Standardize path first so each one starts with / and ends without one
    if standardize_path
      path = '/' + path.split('/').select {|p| !p.empty?}.join('/')
    end

    directory = Directory.find_by_path(path)

    if directory
      return directory
    else
      parent_directories = path.split('/').select { |p| !p.empty?}
      directory_name = parent_directories.pop
      parent_path = '/' + parent_directories.join('/')

      Directory.create(path: path,
                       name: directory_name,
                       parent_id: Directory.create_tree(parent_path, false)[:id])
    end

  end

  def test_statistics(seed_collection = true)
    stats = tests.select('results.category').joins(:result).group(:category).count(:category)

    # make sure all categories are included, where ones not present in above result should be initialized with 0
    if seed_collection
      seed = Result.all.select(:category).distinct.pluck(:category).product([0]).to_h
      stats = seed.merge(stats)
    end

    subdirectories.each do |dir|
      stats = stats.merge(dir.test_statistics(false)) {|k, v1, v2| v1 + v2}
    end

    stats
  end

end