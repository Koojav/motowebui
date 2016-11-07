class Api::RunsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @runs = Run.where(suite_id: params[:suite_id])
    render json: @runs
  end

  def create
    input = JSON.parse(request.body.read)

    # Check if Run with the same name doesn't exist in this Suite's scope already
    @run = Run.where(suite_id: params[:suite_id]).find_by(name: params[:name])

    # If it does - remove it so only the most recent instance of Run results' is being kept in the db
    if @run
      @run.destroy
    end

    # Create new Run with data provided in input
    @run = Run.new input
    @run.suite = Suite.find params[:suite_id]
    @run.save!
    render json: @run
  end

  def update
    @run = Run.find params[:id]
    input = JSON.parse(request.body.read)
    @run.update input
    render json: @run
  end

  def show
    @run = Run.find params[:id]
    render json: @run
  end

end
