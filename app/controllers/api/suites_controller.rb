class Api::SuitesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @suites = Suite.all
    render json: @suites
  end

  def create
    input = JSON.parse(request.body.read)
    @suite = Suite.new input

    begin
      @suite.save!
    rescue ActiveRecord::RecordNotUnique => e
      @suite = Suite.find_by(name: params[:name])
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


  def record_not_unique
    render plain: "Suite with that name already exists.", status: 409
  end

end
