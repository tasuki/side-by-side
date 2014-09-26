angular.module("sideBySide.controllers", [])
.controller "ComparisonController", [
	'$routeParams', '$q', '$scope', 'fetch', 'transformer'
	($routeParams, $q, $scope, fetch, transformer) ->
		$scope.columns = 1
		$scope.verses = [[{
			section: 'Loading...'
			text: 'Please be patient!'
		}]]

		update = (config) ->
			fetch(config).then((result) ->
				$q.all(result.promises).then((results) ->
					$scope.columns = results.length
					transformed = transformer(results)
					$scope.verses = transformed.verses
					$scope.meta = transformed.meta
					headingKey = result.heading or "Author"
					$scope.headings = (version[headingKey] for version in transformed.meta)
				)
			)

		config = if $routeParams.config \
			then $routeParams.config.replace(/\./g, '/') \
			else ''

		update(config + "/config.json")
]
