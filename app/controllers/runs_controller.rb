class RunsController < ApplicationController
  helper_method :testers_all

  def index
    @suite = Suite.find(params[:suite_id])
    @runs = @suite.runs
  end

  def show
    @run = Run.find(params[:id])

    # views/tests/_list is sometimes rendered when using this controller and requires @tests
    @tests = @run.tests
  end

  def testers_all
    @testers_all ||= Tester.all
  end

end
