require 'rest-client'
require 'json'

# Create TestSuite
test_suite = {name: "TestSuite#{rand(9999)}"}
test_suite_json = JSON(test_suite)
test_suite_response = RestClient.post('http://localhost:3000/api/test_suites', test_suite_json)
test_suite_response = JSON.parse(test_suite_response, symbolize_names: true)
test_suite_id = test_suite_response[:id]

# Create TestRun
test_run = {
    name: "TestRun#{rand(9999)}",
    start_time: Time.now
}
test_run_json = JSON(test_run)
test_run_response = RestClient.post("http://localhost:3000/api/test_suites/#{test_suite_id}/test_runs", test_run_json)
test_run_response = JSON.parse(test_run_response, symbolize_names: true)
test_run_id = test_run_response[:id]

# Create 3 Tests
(1..3).each do |i|
  test = {
      name: "Test_#{i}_#{rand(9999)}",
      start_time: Time.now
  }
  test_json = JSON(test)
  RestClient.post("http://localhost:3000/api/test_suites/#{test_suite_id}/test_runs/#{test_run_id}/tests", test_json)
end