class Run < ApplicationRecord
  belongs_to :suite
  belongs_to :result
  has_many :tests

  def display_duration
    begin
      duration = self.end_time - self.start_time
      converted_value = Time.at(duration).utc.strftime("%H:%M:%S")
    rescue
      converted_value = '~'
    end

    converted_value
  end

  def tester_name
    Tester.find(self.tester_id).name
  end

end
