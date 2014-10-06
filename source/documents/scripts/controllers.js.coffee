angular.module("sideBySide.controllers", [])
.controller "AppController", [
	'$scope'
	($scope) ->
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

		poemsUpdated = $rootScope.$on "poemsUpdated", () ->
			results = poems.get()
			$scope.columns = results.length
			transformed = transformer(results)
			$scope.verses = transformed.verses
			$scope.meta = transformed.meta
			headingKey = poems.getHeading() or "Author"
			$scope.headings = (version[headingKey] for version in transformed.meta)

		$scope.$on '$destroy', poemsUpdated
		poems.load $routeParams.base

]
