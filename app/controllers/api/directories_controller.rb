class Api::DirectoriesController < ApplicationController

  skip_before_action :verify_authenticity_token

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

  def update
    directory = Directory.find params[:id]
    input = JSON.parse(request.body.read)
    directory.update input
    render json: directory
  end

  def update_multiple
    directory_ids = params[:directory_ids]
    tester_id = params[:tester_id]

    # Unfortunately updating multiple records via ActiveRecord returns just the amount of rows modified
    Directory.where(id: directory_ids).update_all(tester_id: tester_id)

    render json: directory_ids.map {|id| {id: id, tester_id: tester_id} }
  end

  def show
    render json: Directory.find(params[:id])
  end

  def destroy
    render json: Directory.delete(params[:id])
  end

end
