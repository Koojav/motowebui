class RunsController < ApplicationController

  def index
    @testers = Tester.all
    @suite = Suite.find(params[:suite_id])
    @runs = @suite.runs
  end

  def show
    @testers = Tester.all
    @run = Run.find(params[:id])

    # views/tests/_list is sometimes rendered when using this controller and requires @tests
    @tests = @run.tests
  end

end
