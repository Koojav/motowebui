class Suite < ApplicationRecord
  has_many :runs, dependent: :delete_all

  # Deletes Suite(s) with Runs, Tests and Logs that depend on it
  # @param suite_id Array or Integer
  def self.delete_with_dependencies(suite_id)
    suites = Suite.where(id: suite_id)
    runs = Run.where(suite_id: suite_id)
    tests = Test.where(run_id: runs.ids)
    logs = Log.where(test_id: tests.ids)

    logs.delete_all
    tests.delete_all
    runs.delete_all
    suites.delete_all
  end

  # Deletes all oldest (start_time) Runs above Run limit in this Suite
  def delete_over_limit_runs

    limit = ENV['MWUI_MAX_RUNS_IN_SUITE'].to_i

    if limit > 0
      run_count = runs.size

      if run_count > limit
        excess_run_ids = runs.order(start_time: :desc).last(run_count - limit).pluck(:id)
        Run.delete_with_dependencies(excess_run_ids)
      end
    end

  end

end
