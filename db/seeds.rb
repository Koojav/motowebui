# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Result.create(id: 1, name: 'RUNNING',   category: 'RUNNING')
Result.create(id: 2, name: 'PASS',      category: 'PASS')
Result.create(id: 3, name: 'FAIL',      category: 'FAIL')
Result.create(id: 4, name: 'ERROR',     category: 'ERROR')
Result.create(id: 5, name: 'SKIP',      category: 'SKIP')
Result.create(id: 6, name: 'PASS (M)',  manual: true, category: 'PASS')
Result.create(id: 7, name: 'FAIL (M)',  manual: true, category: 'FAIL')
Result.create(id: 8, name: 'ERROR (M)', manual: true, category: 'ERROR')
Result.create(id: 9, name: 'SKIP (M)',  manual: true, category: 'SKIP')

Tester.create(id: 1, name: 'Not assigned')
Tester.create(id: 2, name: 'John Onion')
Tester.create(id: 3, name: 'Hot Potato')

Suite.create(id: 1, name: 'Test Suite #1')

Run.create(id: 1, name: 'Test Run #1', suite_id: '1', start_time: Time.now - rand(99999), duration: rand(9999))
Run.create(id: 2, name: 'Test Run #2', suite_id: '1', start_time: Time.now - rand(99999), duration: rand(9999))

# Create tests in Run #1
(1..3).each do |i|
  Test.create(name: "Test1_#{i}", run_id: '1', result_id: rand(4)+1, start_time: Time.now - rand(99999), duration: rand(9999))
end

# Create tests in Run #2
(1..50).each do |i|
  Test.create(name: "Test2_#{i}", run_id: '2', result_id: rand(4)+1, start_time: Time.now - rand(99999), duration: rand(9999))
end
