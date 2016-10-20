class Result < ApplicationRecord

  def display_style_btn
    case self.id
      when 1
        result_style = 'btn-info'
      when 2
        result_style = 'btn-success'
      when 3..4
        result_style = 'btn-danger'
      when 5
        result_style = 'btn-warning'
      else
        result_style = 'btn-primary'
    end

    result_style
  end

end
