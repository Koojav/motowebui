class Api::TestersController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Tester.all
  end

  def create
    input = JSON.parse(request.body.read)
    tester = Tester.new(input)
    tester.save!

    render json: tester
  end

  def show
    render json: Tester.find(params[:id])
  end

  def destroy
    tester = Tester.find(params[:id])
    render json: tester.destroy
  end
end
