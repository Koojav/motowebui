class Api::LogsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    @log = Log.new JSON.parse(request.body.read)
    @log.test = Test.find(params[:test_id])
    @log.save!
    render json: @log
  end

  def index
    @log = Log.find_by(test_id: params[:test_id])
    render json: @log
  end
end
