class Test < ApplicationRecord
  belongs_to :run
  belongs_to :result
  has_one    :log, dependent: :destroy

  after_commit :mark_run_as_dirty

  def display_duration
    Time.at(duration).utc.strftime('%H:%M:%S')
  end

  def display_name(max_length = 80)
    length = name.length
    excess = length - (max_length + 3)

    if excess > 0
      return name[0..((length - excess)/2)] + '...' + name[((length + excess)/2)..length]
    end

    name
  end

  # Mark Run as dirty whenever a child Test has been modified so when Run is selected
  # next time it can be validated once with new values based composed from Tests' ones.
  def mark_run_as_dirty
    # Invoked via pure SQL, not via ORM, in order to avoid triggering callbacks in Run
    sql = "UPDATE runs SET result_dirty=1 WHERE runs.id=#{self.run_id};"
    ActiveRecord::Base.connection.execute(sql)
  end

end
