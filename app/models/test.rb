class Test < ApplicationRecord
  belongs_to :run, dependent: :destroy
  belongs_to :result

  def display_duration
    begin
      duration = self.end_time - self.start_time
      converted_value = Time.at(duration).utc.strftime("%H:%M:%S")
    rescue
      converted_value = '~'
    end

    converted_value
  end

end
