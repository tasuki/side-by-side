angular.module('sideBySide', ['ngAnimate', 'ngDialog', 'ngSanitize', 'duScroll'])
	.config [ '$locationProvider', ($locationProvider) ->
		$locationProvider.html5Mode true
	]
