angular.module('sideBySide', ['sideBySide.controllers', 'ngSanitize', 'duScroll'])
	.config [ '$locationProvider', ($locationProvider) ->
		$locationProvider.html5Mode true
	]
