angular.module("sideBySide.controllers", [])
.controller "comparisonController", [
	'$location', '$q', '$scope', 'fetch', 'transformer'
	($location, $q, $scope, fetch, transformer) ->
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

		update(window.location.pathname.slice(0, -1) + $location.path() + "/config.json")
]
