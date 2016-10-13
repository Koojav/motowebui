class TestRun < ApplicationRecord
  belongs_to :test_suite
  has_many :tests
end
