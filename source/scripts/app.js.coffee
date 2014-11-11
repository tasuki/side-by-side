angular.module('sideBySide', ['sideBySide.controllers', 'ngRoute', 'ngSanitize'])
	.config [ '$locationProvider', ($locationProvider) ->
		$locationProvider.html5Mode true
	]
