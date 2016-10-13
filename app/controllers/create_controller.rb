require 'rest-client'

class CreateController < ApplicationController

  def index

    # Create TestSuite
    test_suite = {name: "TestSuite#{rand(9999)}"}
    test_suite_json = JSON(test_suite)
    response = RestClient.post('http://localhost:3000/api/test_suites', test_suite_json)

    # Create TestRun
    test_run = {
        name: "TestRun#{rand(9999)}",
        test_suite_id: response[:id],
        start_time: Time.now
    }
    test_run_json = JSON(test_run)
    response = RestClient.post('http://localhost:3000/api/test_runs', test_run_json)


    render json: response

  end

end
