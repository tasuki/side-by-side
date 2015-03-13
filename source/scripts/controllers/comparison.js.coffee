angular.module("sideBySide").controller "ComparisonController",
['$document', '$rootScope', '$scope', 'filter', 'load', 'poems', 'route', 'transformer'
($document, $rootScope, $scope, filter, load, poems, route, transformer) ->
	min = 1
	max = 5

	scroll = ->
		setTimeout ->
			if 'section' of route.params
				section = 'section-' + route.params['section']
				element = document.getElementById section
				$document.scrollTo(element, 10, 200) if element
		, 1

	$rootScope.$on 'duScrollspy:becameActive', ($event, $element) ->
		if not $scope.meta[0].Loading
			route.update 'section', $element.prop('id').replace('section-', '')
			$rootScope.$apply()

	$scope.$watchCollection ->
		poems.getActive()
	, ->
		active = poems.getActive()

		$scope.columns = active.length
		transformed = transformer active
		$scope.verses = transformed.verses
		$scope.meta = transformed.meta

		headingKey = poems.config.heading or "Author"
		$scope.headings = (version[headingKey] for version in transformed.meta)

		$scope.metaKeys = poems.getMetaKeys()
		$scope.all = poems.all
		scroll()

		if not $scope.meta[0].Loading
			route.update 'display', filter.getFilter()

	$scope.switchActive = (poem) ->
		length = poems.getActive().length
		active = poem.meta.Active
		if (length > min or not active) and (length < max or active)
			poem.meta.Active = ! active
			# TODO else notification

	load(
		route.getBaseDir()
		route.params.display
	)
]
