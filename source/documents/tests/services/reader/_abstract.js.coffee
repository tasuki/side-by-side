this.testReader = (name, testCases) ->
	reader = injector.get(name)

	for testCase in testCases
		deepEqual(reader(testCase.tested), testCase.expected)
