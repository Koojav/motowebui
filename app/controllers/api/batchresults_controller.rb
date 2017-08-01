class Api::BatchresultsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def update
    test_ids = params[:test_ids]
    result_id = params[:result_id]

    result_ids = []
    test_ids.length.times do
      result_ids << {result_id: result_id}
    end

    result = Test.update(test_ids, result_ids)
    render json: result
  end

end
