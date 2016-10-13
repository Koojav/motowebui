class Api::TestSuitesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    offset = params[:offset] || 0
    limit = params[:limit] || 20
    @test_suites = TestSuite.order('id DESC').offset(offset).limit(limit)
    render json: @test_suites
  end

  def create
    input = JSON.parse(request.body.read)
    @test_suite = TestSuite.new input
    @test_suite.save!
    render json: @test_suite
  end

  def update
    @test_suite = TestSuite.find params[:id]
    input = JSON.parse(request.body.read)
    @test_suite.update input
    render json: @test_suite
  end

  def show
    @test_suite = TestSuite.find params[:id]
    render json: @test_suite
  end

end
