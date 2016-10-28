class TestsController < ApplicationController

  def index
    @run = Run.find(params[:run_id])
    @tests = @run.tests
  end

  def show
    @test = Test.find(params[:id])
  end

end
