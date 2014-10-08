angular.module("sideBySide.controllers", [])
.controller "AppController", [
	'$routeParams', '$scope', 'poems'
	($routeParams, $scope, poems) ->
		$scope.$on "$routeChangeSuccess", ($currentRoute, $previousRoute) ->
			$scope.base = if $previousRoute.params.base \
				then '/' + $previousRoute.params.base
				else ''

		poems.load $routeParams.base
]

.controller "ComparisonController", [
	'$scope', 'poems', 'transformer'
	($scope, poems, transformer) ->
		$scope.$watchCollection () ->
			poems.active.length
		, () ->
			$scope.columns = poems.active.length
			transformed = transformer(poems.active)
			$scope.verses = transformed.verses
			$scope.meta = transformed.meta

			headingKey = poems.heading or "Author"
			$scope.headings = (version[headingKey] for version in transformed.meta)
]
