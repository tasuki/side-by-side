angular.module('sideBySide', ['sideBySide.controllers', 'ngDialog', 'ngSanitize', 'duScroll'])
	.config [ '$locationProvider', ($locationProvider) ->
		$locationProvider.html5Mode true
	]
