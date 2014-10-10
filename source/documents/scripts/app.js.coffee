angular.module('sideBySide', ['sideBySide.controllers', 'ngRoute', 'ngSanitize'])
	.config [ '$routeProvider', ($routeProvider) ->
		$routeProvider
			.when '/:base?/pick', {
				templateUrl: 'partials/pick.html'
				controller: 'PickController'
			}
			.when '/:base?', {
				templateUrl: 'partials/comparison.html'
				controller: 'ComparisonController'
			}
	]
