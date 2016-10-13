class Api::TestRunsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    offset = params[:offset] || 0
    limit = params[:limit] || 20
    @test_runs = TestRun.order('id DESC').offset(offset).limit(limit)
    render json: @test_runs
  end

  def create
    input = JSON.parse(request.body.read)
    @test_run = TestRun.new input
    @test_run.test_suite = TestSuite.find params[:test_suite_id]
    @test_run.save!
    render json: @test_run
  end

  def update
    @test_run = TestRun.find params[:id]
    input = JSON.parse(request.body.read)
    @test_run.update input
    render json: @test_run
  end

  def show
    @test_run = TestRun.find params[:id]
    render json: @test_run
  end

end
