class Directory < ApplicationRecord
  has_many :directories
  has_many :tests

  def subdirectories
    Directory.where(directory_id: id)
  end

end
