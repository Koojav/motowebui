class Api::MotoresultsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create

    if !params[:tests] || !params[:path] || !params[:tester_id]
      return head(:bad_request)
    end

    directory = Directory.create_tree(params[:path])
    directory_id = directory[:id]

    tests_data = params[:tests]

    tests = []

    tests_data.each do |test_data|
      tests << Test.create_uniq_in_dir(directory_id, test_data.to_hash.symbolize_keys)
    end

    render json: tests
  end

end
