class Api::MotoresultsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create

    if !params[:tests] || !params[:path] || !params[:tester_id]
      return head(:bad_request)
    end

    tests_data = params[:tests].map! { |test_data| test_data.to_unsafe_h.symbolize_keys }
    directory     = Directory.create_tree(params[:path])

    directory.update!(tester_id: params[:tester_id])

    tests = Test.create_uniq_in_dir(tests_data, directory.id)
    render json: tests
  end

end
