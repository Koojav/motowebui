class Api::RunsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Directory.where(directory_id: params[:parent_id])
  end

  def create
    # Must be able to parse single and array of items
  end

  def update
    # Must be able to parse single and array of items
  end

  def show
    render json: Directory.find(params[:id])
  end

  def destroy
    render json: Directory.delete(params[:id])
  end

end
