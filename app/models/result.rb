class Result < ApplicationRecord
  has_many    :tests

  def display_style_btn
    case self.category
      when 'RUNNING'
        result_style = 'btn-info'
      when 'PASS'
        result_style = 'btn-success'
      when 'FAIL'
        result_style = 'btn-danger'
      when 'ERROR'
        result_style = 'btn-danger'
      when 'SKIP'
        result_style = 'btn-warning'
      else
        result_style = 'btn-primary'
    end

    result_style
  end
end
