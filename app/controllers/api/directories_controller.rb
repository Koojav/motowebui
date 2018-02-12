class Api::DirectoriesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    created_directories = []

    if params.has_key?(:directories)

      params[:directories].each do |directory|
        created_directories << Directory.create_tree(directory[:path])
      end

    elsif params.has_key?(:directory) && params[:directory][:path]
      created_directories << Directory.create_tree(params[:directory][:path])
    else
      raise "No 'directory' or 'directories' keys found in request parameters."
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

    tester_name = Tester.where(id: tester_id).pluck(:name)[0]

    render json: directory_ids.map {|id| {id: id, tester_id: tester_id, tester_name: tester_name} }
  end

  def show
    render json: Directory.find(params[:id])
  end

  def destroy
    render json: Directory.delete(params[:id])
  end

end
