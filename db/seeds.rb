# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Result.create(id: 1, name: 'pass')
Result.create(id: 2, name: 'fail')
Result.create(id: 3, name: 'skip')
Result.create(id: 4, name: 'manual')

Suite.create(id: 1, name: 'TestSuite1')

Run.create(id: 1, name: 'TestRun1', suite_id: '1')

Test.create(id: 1, name: 'Test1_1', run_id: '1', result_id: '1')
Test.create(id: 2, name: 'Test2_1', run_id: '1', result_id: '2')
Test.create(id: 3, name: 'Test3_1', run_id: '1', result_id: '3')
