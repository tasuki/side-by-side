angular.module("sideBySide").controller "AppController",
['$scope', 'ngDialog', 'filter', 'poems'
($scope, ngDialog, filter, poems) ->
	$scope.title = =>
		poems.config.title || 'Side By Side viewer'

	$scope.$watchCollection ->
		poems.config
	, ->
		if 'links' of poems.config
			$scope.links = poems.config.links.map (link) ->
				link.display = JSON.stringify link.display
				link

	$scope.display = (encoded) ->
		filter.setFilter JSON.parse encoded

	$scope.showPage = (page) ->
		ngDialog.open {
			template: 'partials/' + page + '.html'
		}

	$scope.flipPick = ->
		$scope.pick = not $scope.pick

	$scope.pick = false
]
