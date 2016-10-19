class RunsController < ApplicationController
  helper_method :run_duration, :tester_name

  def index
    @runs = Run.all
  end

  def show
    @run = Run.find(params[:id])
  end

  def run_duration(run)
    begin
      run.end_time - run.start_time
    rescue
      '~'
    end
  end

  def tester_name
    'Janusz Cebulator'
  end

end
