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

  def update_multiple
    test_ids = params[:test_ids]
    result_id = params[:result_id]
    tester_id = params[:tester_id]

    query_data = params.permit(:result_id, :tester_id).to_h

    Test.where(id: test_ids).update_all(query_data)
    if tester_id
      tester_name = Tester.where(id: tester_id).pluck(:name)[0]
    end

    # Unfortunately updating multiple records via ActiveRecord returns just the amount of rows modified
    render json: test_ids.map { |id| {
        id: id,
        result_id: result_id,
        tester_name: tester_name}
    }
  end

end
