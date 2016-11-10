class Test < ApplicationRecord
  belongs_to :run
  belongs_to :result

  after_commit :evaluate_run_result

  def display_duration
    begin
      duration = self.end_time - self.start_time
      converted_value = Time.at(duration).utc.strftime("%H:%M:%S")
    rescue
      converted_value = '~'
    end

    converted_value
  end

  def display_name(max_length = 50)
    length = name.length
    excess = length - (max_length + 3)

    if excess > 0
      return name[0..((length - excess)/2)] + '...' + name[((length + excess)/2)..length]
    else
      return name
    end
  end

  # Evaluates run.result based on run.tests.categories
  # TODO: Make it a delayed job
  def evaluate_run_result
    categories = run.tests.select('results.category').joins(:result).group('results.category').pluck('category')

    if categories.include? 'RUNNING'
      run.result = Result.find(1)
    elsif categories.include? 'ERROR'
      run.result = Result.find(4)
    elsif categories.include? 'FAIL'
      run.result = Result.find(3)
    elsif categories.include? 'SKIP'
      run.result = Result.find(5)
    else
      run.result = Result.find(2)
    end
    run.save!
  end
  private :evaluate_run_result

end
