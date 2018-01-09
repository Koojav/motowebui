if Result.all.empty?
  Result.create(id: 1, name: 'RUNNING',   category: 'RUNNING')
  Result.create(id: 2, name: 'PASS',      category: 'PASS')
  Result.create(id: 3, name: 'FAIL',      category: 'FAIL')
  Result.create(id: 4, name: 'ERROR',     category: 'ERROR')
  Result.create(id: 5, name: 'SKIP',      category: 'SKIP')
  Result.create(id: 6, name: 'PASS (M)',  manual: true, category: 'PASS')
  Result.create(id: 7, name: 'FAIL (M)',  manual: true, category: 'FAIL')
  Result.create(id: 8, name: 'ERROR (M)', manual: true, category: 'ERROR')
  Result.create(id: 9, name: 'SKIP (M)',  manual: true, category: 'SKIP')
end

if Directory.all.empty?
  Directory.create([
    {id: 0, path: '/'},
    {id: 1, path: '/level1', directory_id: 0},
    {id: 2, path: '/level1/level2/', directory_id: 1},
    {id: 3, path: '/level1/level2/level3A', directory_id: 2},
    {id: 4, path: '/level1/level2/level3B', directory_id: 2},
  ])
end

if Test.all.empty?
  Test.create([
    {name: "Test 3A1", directory_id: 3},
    {name: "Test 3A2", directory_id: 3},
    {name: "Test 3A3", directory_id: 3},
    {name: "Test 3B1", directory_id: 4},
    {name: "Test 3B2", directory_id: 4},
    {name: "Test 3B3", directory_id: 4},
  ])
end

if Tester.all.empty?
  Tester.create(id: 1, name: 'Not assigned')
end


