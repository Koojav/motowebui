class RunsController < ApplicationController

  def index
    @runs = Run.where(suite_id: params[:suite_id])
  end

  def show
    @run = Run.find(params[:id])
    @tests = Test.where(run_id: params[:id])

    # @tests_pass = @tests.group(:type).size
    # true
  end

end
