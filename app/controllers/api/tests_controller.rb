class Api::TestsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Test.where(directory_id: params[:directory_id])
  end

  def create
    tests_data = params[:tests]

    if !tests_data || !params[:directory_id]
      return head(:bad_request)
    end

    tests = []

    tests_data.each do |test_data|
      tests << Test.create_uniq_in_dir(params[:directory_id], test_data.to_hash.symbolize_keys)
    end

    render json: tests
  end


  def show
    render json: Test.find(params[:id])
  end

  def destroy
    render json: Test.delete(params[:id])
  end

end
