class Api::RunsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    offset = params[:offset] || 0
    limit = params[:limit] || 20
    @runs = Run.order('id DESC').offset(offset).limit(limit)
    render json: @runs
  end

  def create
    input = JSON.parse(request.body.read)
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
