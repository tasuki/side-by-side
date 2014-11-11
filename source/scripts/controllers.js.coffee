angular.module("sideBySide.controllers", [])
.controller "AppController", [
	() -> null
]
.controller "ComparisonController", [
	'$scope', '$anchorScroll', 'route', 'poems', 'transformer'
	($scope, $anchorScroll, route, poems, transformer) ->
		min = 1
		max = 5

		scroll = () ->
			setTimeout () ->
				if ('section' of route.params)
					section = 'section-' + route.params['section']
					element = document.getElementById(section)
					element.scrollIntoView() if element
			, 100

		$scope.$watchCollection () ->
			poems.getActive()
		, () ->
			active = poems.getActive()

			$scope.columns = active.length
			transformed = transformer(active)
			$scope.verses = transformed.verses
			$scope.meta = transformed.meta

			headingKey = poems.heading or "Author"
			$scope.headings = (version[headingKey] for version in transformed.meta)

			$scope.all = poems.all
			scroll()

		$scope.switchActive = (poem) ->
			length = poems.getActive().length
			active = poem.meta.Active
			if ((length > min or not active) and (length < max or active))
				poem.meta.Active = not poem.meta.Active
				# TODO else notification

		$scope.flipPick = () ->
			$scope.pick = not $scope.pick

		$scope.pick = false

		poems.load route.appUrl + '/' + route.params.base
]