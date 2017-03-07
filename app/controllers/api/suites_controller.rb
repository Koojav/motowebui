class Api::SuitesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Suite.all
  end

  def create
    # Case insensitive check for already existing TestSuite with provided name
    suite = Suite.find_by(name: params[:name].downcase)

    # If it didn't exist - create it
    if suite.nil?
      input = JSON.parse(request.body.read)
      suite = Suite.new(input)
      suite.save!
    end

    render json: suite
  end

  def update
    suite = Suite.find(params[:id])
    input = JSON.parse(request.body.read)
    suite.update(input)
    render json: suite
  end

  def show
    render json: Suite.find(params[:id])
  end

  def destroy
    render json: Suite.delete_with_dependencies(params[:id])
  end

end
