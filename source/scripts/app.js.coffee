angular.module('sideBySide', ['sideBySide.controllers', 'ngRoute', 'ngSanitize'])
	.config [ '$routeProvider', ($routeProvider) ->
		$routeProvider.when '/:base?/:section?', {
			templateUrl: 'partials/comparison.html'
			controller: 'ComparisonController'
		}
	]
