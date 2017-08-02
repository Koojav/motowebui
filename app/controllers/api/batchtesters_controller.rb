class Api::BatchtestersController < ApplicationController

  skip_before_action :verify_authenticity_token

  def update
    run_ids = params[:run_ids]
    tester_id = params[:tester_id]

    tester_ids = []
    run_ids.length.times do
      tester_ids << {tester_id: tester_id}
    end

    result = Run.update(run_ids, tester_ids)
    render json: result
  end

end
