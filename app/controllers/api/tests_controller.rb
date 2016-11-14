class Api::TestsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index

    # if params[:datatable]
    #   tests = {}
    #   tests[:draw] = params[:draw]
    #   total = Test.where(run_id: params[:run_id]).count(:id)
    #   tests[:recordsTotal]    = total
    #   tests[:recordsFiltered] = total
    #   tests[:data] = []
    #
    #   order_hash = {column:params[:order]['0']['column'], dir:params[:order]['0']['dir']}
    #   order_str = "#{params[:columns][order_hash[:column]]['name']} #{order_hash['dir']}"
    #
    #   tests_db = Test.where(run_id: params[:run_id]).offset(params[:start].to_i).limit(params[:length].to_i).order(order_str)
    #   tests_db.each do |test|
    #     tests[:data] << [test.id, test.name, test.start_time, test.display_duration, test.result.name]
    #   end
    #   render json: tests
    # else
      render json: Test.where(run_id: params[:run_id])
    # end
  end

  def create
    input = JSON.parse(request.body.read)
    test = Test.new input
    test.run = Run.find params[:run_id]
    test.save!
    render json: test
  end

  def update
    test = Test.find(params[:id])
    input = JSON.parse(request.body.read)
    test.update(input)
    render json: test
  end

  def show
    render json: Test.find(params[:id])
  end

  def destroy
    test = Test.find(params[:id])
    render json: test.destroy
  end

end
