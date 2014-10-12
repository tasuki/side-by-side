angular.module("sideBySide.controllers", [])
.controller "AppController", [
	'$location', '$scope', 'poems'
	($location, $scope, poems) ->
		$scope.$on "$routeChangeSuccess", ($currentRoute, $previousRoute) ->
			$scope.base = if $previousRoute.params.base \
				then '/' + $previousRoute.params.base
				else ''

		appUrl = $location.absUrl()
			.substring(0, $location.absUrl().length - $location.url().length)
			.replace(/#$/, '')

		base = appUrl + $location.url()
			.slice(1)
			.replace(/(.*)\/.*/, '$1')
			.replace(/\./g, '/')

		poems.load base
]

.controller "ComparisonController", [
	'$scope', 'poems', 'transformer'
	($scope, poems, transformer) ->
		min = 1
		max = 5

		$scope.$watchCollection () ->
			poems.getActive()
		, () ->
			active = poems.getActive()

			$scope.columns = active.length
			transformed = transformer(active)
			$scope.verses = transformed.verses
			$scope.meta = transformed.meta

			headingKey = poems.heading or "Author"
			$scope.headings = (version[headingKey] for version in transformed.meta)

			$scope.all = poems.all

		$scope.switchActive = (poem) ->
			length = poems.getActive().length
			active = poem.meta.Active
			if ((length > min or not active) and (length < max or active))
				poem.meta.Active = not poem.meta.Active
				# TODO else notification

		$scope.flipPick = () ->
			$scope.pick = not $scope.pick

		$scope.pick = false
]
