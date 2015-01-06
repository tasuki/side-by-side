angular.module('sideBySide', ['ngDialog', 'ngSanitize', 'duScroll'])
	.config [ '$locationProvider', ($locationProvider) ->
		$locationProvider.html5Mode true
	]
