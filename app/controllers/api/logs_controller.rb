class Api::LogsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def show
    render json: Log.find_by(test_id: params[:test_id])
  end

  def create
    log = Log.new JSON.parse(request.body.read)
    log.test = Test.find(params[:test_id])
    log.save!
    render json: log
  end

  def update
    log = Test.find(params[:test_id]).log
    input = JSON.parse(request.body.read)
    log.update(input)
    render json: log
  end

  def destroy
    log = Log.find(params[:id])
    render json: log.destroy
  end

end
