class Api::RunsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Run.where(suite_id: params[:suite_id])
  end

  def create
    input = JSON.parse(request.body.read)

    # Check if Run with the same name doesn't exist in this Suite's scope already
    run = Run.where(suite_id: params[:suite_id]).find_by(name: params[:name])

    # If it does - remove it so only the most recent instance of Run results' is being kept in the db
    if run
      # Store run's ID so once it's created anew with new set of tests URLs
      # will still point to the same Test Run, just with different content
      stored_id = run.id
      run.destroy
    end

    # Create new Run with data provided in input
    run = Run.new input
    run.suite = Suite.find params[:suite_id]

    if stored_id
      run.id = stored_id
    end

    run.save!
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
    run = Run.find(params[:id])
    render json: run.destroy
  end

end
