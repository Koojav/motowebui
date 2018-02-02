if Tester.all.empty?
  Tester.create(id: 1, name: 'Not assigned')
end

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
  Directory.create(path: '/', name: '/', id: 0)
end


