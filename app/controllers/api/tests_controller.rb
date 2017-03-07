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
    # Check if Test with the same name doesn't exist in this Run's scope already
    run = Run.find(params[:run_id])
    test = run.tests.find_by(name: params[:name].downcase)

    # If it did exist - store it's ID and destroy it
    if test
      # Store Test's ID so once it's created anew its URL will stil point to the same object
      stored_id = test.id
      Test.delete_with_dependencies(stored_id)
    end

    # Create new Test with data provided in input
    input = JSON.parse(request.body.read)
    test = Test.new(input)
    test.run = run

    if stored_id
      test.id = stored_id
    end

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
    render json: Test.delete_with_dependencies(params[:id])
  end

end
