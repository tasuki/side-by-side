angular.module('sideBySide', ['sideBySide.controllers', 'ngRoute', 'ngSanitize', 'duScroll'])
	.config [ '$locationProvider', ($locationProvider) ->
		$locationProvider.html5Mode true
	]
