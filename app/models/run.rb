class Run < ApplicationRecord
  belongs_to :suite
  belongs_to :result
  has_many   :tests, dependent: :destroy

  after_find :validate_result, if: :result_dirty

  def display_duration
    begin
      converted_value = Time.at(self.duration).utc.strftime("%H:%M:%S")
    rescue
      converted_value = '~'
    end

    converted_value
  end

  def tester_name
    Tester.find(self.tester_id).name
  end

  # Evaluates run.result based on run.tests.categories
  def validate_result
    categories = tests.select('results.category').joins(:result).group('results.category').pluck('category')

    if categories.include? 'RUNNING'
      self.result = Result.find(1)
    elsif categories.include? 'ERROR'
      self.result = Result.find(4)
    elsif categories.include? 'FAIL'
      self.result = Result.find(3)
    elsif categories.include? 'SKIP'
      self.result = Result.find(5)
    else
      self.result = Result.find(2)
    end

    self.result_dirty = false
    self.save!
  end

end
