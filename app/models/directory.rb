class Directory < ApplicationRecord
  has_many :directories
  has_many :tests

  def subdirectories
    Directory.where(parent_id: id)
  end

  def self.create_tree(path)
    # Standardize path first so each one starts with / and ends without one
    path = '/' + path.split('/').select {|p| !p.empty?}.join('/')

    directory = Directory.find_by_path(path)

    if directory
      return directory
    else
      parent_directories = path.split('/').select { |p| !p.empty?}
      parent_directories.pop
      parent_path = '/' + parent_directories.join('/')

      Directory.create(path: path, parent_id: Directory.create_tree(parent_path)[:id])
    end

  end

end
