class Api::RunsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Run.where(suite_id: params[:suite_id])
  end

  def create
    # Check if Run with the same name doesn't exist in this Suite's scope already
    suite = Suite.find(params[:suite_id])
    run = suite.runs.find_by(name: params[:name].downcase)
    input = JSON.parse(request.body.read)

    # If it didn't exist - create it
    if run.nil?
      run = Run.new(input)
      run.suite = suite
    # If it did - update attributes that might have changed
    elsif input.key?('tester_id')
      run.tester_id = input['tester_id']
    end
    run.save!

    # Makes sure that amount of Runs in a Suite doesn't exceed one set in ENV['MWUI_MAX_RUNS_IN_SUITE']
    suite.delete_over_limit_runs

    render json: run
  end

  def update
    run = Run.find params[:id]
    input = JSON.parse(request.body.read)
    run.update input
    render json: run
  end

  def show
    render json: Run.find(params[:id])
  end

  def destroy
    render json: Run.delete_with_dependencies(params[:id])
  end

end
