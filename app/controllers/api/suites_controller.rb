class Api::SuitesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    offset = params[:offset] || 0
    limit = params[:limit] || 20
    @suites = Suite.order('id DESC').offset(offset).limit(limit)
    render json: @suites
  end

  def create
    input = JSON.parse(request.body.read)
    @suite = Suite.new input
    @suite.save!
    render json: @suite
  end

  def update
    @suite = Suite.find params[:id]
    input = JSON.parse(request.body.read)
    @suite.update input
    render json: @suite
  end

  def show
    @suite = Suite.find params[:id]
    render json: @suite
  end

end
