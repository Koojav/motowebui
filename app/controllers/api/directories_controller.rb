class Api::DirectoriesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Directory.find(params[:id]).subdirectories
  end

  def create
    if params.has_key?(:directory)
      directories = [params[:directory]]
    elsif params.has_key?(:directories)
      directories = params[:directories]
    else
      raise "No 'directory' or 'directories' keys found in request parameters."
    end

    created_directories = []

    directories.each do |directory|
      created_directories << Directory.create_tree(directory[:path])
    end

    render json: created_directories
  end

  def show
    render json: Directory.find(params[:id])
  end

  def destroy
    render json: Directory.delete(params[:id])
  end

end
