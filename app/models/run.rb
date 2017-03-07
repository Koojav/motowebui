class Run < ApplicationRecord
  belongs_to :suite
  belongs_to :tester
  has_many   :tests, dependent: :delete_all

  after_find :validate_stats, if: :stats_dirty

  def display_duration
    Time.at(duration).utc.strftime('%H:%M:%S')
  end

  # Evaluates Tests' statistics for this Run
  def validate_stats
    stats = tests.select('results.category').joins(:result).group(:category).count(:category)

    self.stats_tests_all     = tests.length
    self.stats_tests_running = stats.key?('RUNNING')  ? stats['RUNNING'] : 0
    self.stats_tests_error   = stats.key?('ERROR')    ? stats['ERROR']   : 0
    self.stats_tests_fail    = stats.key?('FAIL')     ? stats['FAIL']    : 0
    self.stats_tests_skip    = stats.key?('SKIP')     ? stats['SKIP']    : 0
    self.stats_tests_pass    = stats.key?('PASS')     ? stats['PASS']    : 0

    self.stats_dirty = false
    self.save!
  end

  def self.delete_with_dependencies(run_id)
    run = Run.includes(:tests).find(run_id)
    tests = run.tests
    logs = Log.where(test_id: tests.ids)

    logs.delete_all
    tests.delete_all
    run.delete
  end

end
