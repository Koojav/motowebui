class Suite < ApplicationRecord
  has_many :runs, dependent: :delete_all

  def self.delete_with_dependencies(suite_id)
    suite = Suite.includes(:runs).find(suite_id)
    runs = suite.runs.includes(:tests)
    tests = Test.where(run_id: runs.ids)
    logs = Log.where(test_id: tests.ids)

    logs.delete_all
    tests.delete_all
    runs.delete_all
    suite.delete
  end
end
