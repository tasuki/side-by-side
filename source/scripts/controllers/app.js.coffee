angular.module("sideBySide").controller "AppController",
['$scope', 'ngDialog', 'poems'
($scope, ngDialog, poems) ->
	$scope.title = =>
		sbs = 'Side By Side viewer'
		if poems.config.title
			poems.config.title + ' – ' + sbs
		else
			sbs

	$scope.showPage = (page) ->
		ngDialog.open {
			template: 'partials/' + page + '.html'
		}
]
