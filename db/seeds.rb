# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Result.create(id: 1, name: 'pass')
Result.create(id: 2, name: 'fail')
Result.create(id: 3, name: 'error')
Result.create(id: 4, name: 'skip')
Result.create(id: 5, name: 'manual')

Suite.create(id: 1, name: 'Test Suite #1')

Run.create(id: 1, name: 'Test Run #1', suite_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
Run.create(id: 2, name: 'Test Run #2', suite_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )

Test.create(name: 'Test1_1', run_id: '1', result_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test2_1', run_id: '1', result_id: '2', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test3_1', run_id: '1', result_id: '3', start_time: Time.now - rand(99999), end_time: Time.now )

Test.create(name: 'Test1_2', run_id: '2', result_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test2_2', run_id: '2', result_id: '2', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test3_2', run_id: '2', result_id: '3', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test4_2', run_id: '2', result_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test5_2', run_id: '2', result_id: '4', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test6_2', run_id: '2', result_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test7_2', run_id: '2', result_id: '2', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test8_2', run_id: '2', result_id: '5', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test9_2', run_id: '2', result_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test10_2', run_id: '2', result_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test11_2', run_id: '2', result_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test12_2', run_id: '2', result_id: '2', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test13_2', run_id: '2', result_id: '3', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test14_2', run_id: '2', result_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test15_2', run_id: '2', result_id: '4', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test16_2', run_id: '2', result_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test17_2', run_id: '2', result_id: '2', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test18_2', run_id: '2', result_id: '5', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test19_2', run_id: '2', result_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
Test.create(name: 'Test20_2', run_id: '2', result_id: '1', start_time: Time.now - rand(99999), end_time: Time.now )
