class Api::TestsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    offset = params[:offset] || 0
    limit = params[:limit] || 20
    @tests = Test.order('id DESC').offset(offset).limit(limit)
    render json: @tests
  end

  def create
    input = JSON.parse(request.body.read)
    @test = Test.new input
    @test.run = Run.find params[:run_id]
    @test.save!
    render json: @test
  end

  def update
    @test = Test.find params[:id]
    input = JSON.parse(request.body.read)
    @test.update input
    render json: @test
  end

  def show
    @test = Test.find params[:id]
    render json: @test
  end
end
