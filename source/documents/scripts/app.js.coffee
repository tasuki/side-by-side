angular.module('sideBySide', ['sideBySide.controllers', 'ngRoute', 'ngSanitize'])
	.config [ '$routeProvider', ($routeProvider) ->
		$routeProvider
			.when '/:config?', {
				templateUrl: 'partials/comparison.html'
				controller: 'ComparisonController'
			}
	]
