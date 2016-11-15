class Api::ResultsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Result.all
  end

  def create
    input = JSON.parse(request.body.read)
    result = Result.new(input)
    result.save!

    render json: result
  end

  def show
    render json: Result.find(params[:id])
  end

  def destroy
    result = Result.find(params[:id])
    render json: result.destroy
  end
end
