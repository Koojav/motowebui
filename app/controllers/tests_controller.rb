class TestsController < ApplicationController

  def index
    @tests = Test.where(run_id: params[:run_id])
  end

  def show
    @test = Test.find(params[:id])
  end

end
