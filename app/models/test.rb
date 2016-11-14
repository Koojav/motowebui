class Test < ApplicationRecord
  belongs_to :run
  belongs_to :result
  has_one    :log, dependent: :destroy

  after_commit :mark_run_as_dirty

  def display_duration
    begin
      converted_value = Time.at(self.duration).utc.strftime("%H:%M:%S")
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

  def mark_run_as_dirty
    # Invoked via pure SQL, not via ORM, in order to avoid triggering callbacks in Run
    sql = "UPDATE runs SET result_dirty=1 WHERE runs.id=#{self.run_id};"
    ActiveRecord::Base.connection.execute(sql)
  end

end
