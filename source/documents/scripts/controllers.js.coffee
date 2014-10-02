angular.module("sideBySide.controllers", [])
.controller "AppController", [
	'$routeParams', '$scope'
	($routeParams, $scope) ->
		$scope.$on "$routeChangeSuccess", ($currentRoute, $previousRoute) ->
			$scope.base = if $previousRoute.params.base \
				then '/' + $previousRoute.params.base
				else ''
]

.controller "ComparisonController", [
	'$routeParams', '$rootScope', '$scope', 'poems', 'transformer'
	($routeParams, $rootScope, $scope, poems, transformer) ->
		$scope.columns = 1
		$scope.verses = [[{
			section: 'Loading...'
			text: 'Please be patient!'
		}]]

		$rootScope.$on "poemsLoaded", () ->
			results = poems.get()
			$scope.columns = results.length
			transformed = transformer(results)
			$scope.verses = transformed.verses
			$scope.meta = transformed.meta
			headingKey = poems.getHeading() or "Author"
			$scope.headings = (version[headingKey] for version in transformed.meta)

		config = if $routeParams.base \
			then $routeParams.base.replace(/\./g, '/') \
			else ''

		poems.update(config + "/config.json")
]
