class Test < ApplicationRecord
  belongs_to :run
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

  def display_name(max_length = 50)
    length = name.length
    excess = length - (max_length + 3)

    if excess > 0
      return name[0..((length - excess)/2)] + '...' + name[((length + excess)/2)..length]
    else
      return name
    end

  end

end
