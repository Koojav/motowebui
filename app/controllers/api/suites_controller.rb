class Api::SuitesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @suites = Suite.all
    render json: @suites
  end

  def create
    # Case insensitive check for already existing TestSuite with provided name
    @suite = Suite.find_by(name: params[:name].downcase)

    # If it didn't exist - create it
    if @suite.nil?
      input = JSON.parse(request.body.read)
      @suite = Suite.new input
      @suite.save!
    end

    render json: @suite
  end

  def update
    @suite = Suite.find params[:id]
    input = JSON.parse(request.body.read)
    @suite.update input
    render json: @suite
  end

  def show
    @suite = Suite.find(params[:id])
    render json: @suite
  end

end
