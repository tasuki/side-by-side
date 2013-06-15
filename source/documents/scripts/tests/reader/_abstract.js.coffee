this.testReader = (name, testCases) ->
	injector = angular.injector(["ng", "sideBySide"])
	reader = injector.get(name)

	for testCase in testCases
		deepEqual(reader(testCase.tested), testCase.expected)
