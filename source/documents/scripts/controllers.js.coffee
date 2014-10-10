angular.module("sideBySide.controllers", [])
.controller "AppController", [
	'$location', '$scope', 'poems'
	($location, $scope, poems) ->
		$scope.$on "$routeChangeSuccess", ($currentRoute, $previousRoute) ->
			$scope.base = if $previousRoute.params.base \
				then '/' + $previousRoute.params.base
				else ''

		base = $location.url().replace(/\/(.*)\/.*/, '$1')
		poems.load base
]

.controller "ComparisonController", [
	'$scope', 'poems', 'transformer'
	($scope, poems, transformer) ->
		$scope.$watch () ->
			(poem for poem in poems.all when poem.meta.Active is true).length
		, () ->
			active = (poem for poem in poems.all when poem.meta.Active is true)

			$scope.columns = active.length
			transformed = transformer(active)
			$scope.verses = transformed.verses
			$scope.meta = transformed.meta

			headingKey = poems.heading or "Author"
			$scope.headings = (version[headingKey] for version in transformed.meta)
]

.controller "PickController", [
	'$scope', 'poems'
	($scope, poems) ->
		$scope.$watch () ->
			(poem for poem in poems.all when poem.meta.Active is true).length
		, () ->
			$scope.poems = poems.all
]
