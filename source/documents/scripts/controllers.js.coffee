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

#.controller "notificationController", ['$scope', '$timeout', ($scope, $timeout) ->
#	$scope.id = 0
#	$scope.notifications = []
#
#	$scope.notify = (text, type = "info") ->
#		$scope.notifications[$scope.id] = {
#			text: text
#			type: type
#		}
#		$timeout(() ->
#			$scope.remove($scope.id)
#		, 1000)
#		$scope.id++
#
#	$scope.remove = (id) ->
#		delete $scope.notifications[id]
#]
