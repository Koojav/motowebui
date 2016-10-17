class Run < ApplicationRecord
  belongs_to :suite
  has_many :tests
end
