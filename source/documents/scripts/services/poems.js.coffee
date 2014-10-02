angular.module("sideBySide").service "poems", ['$rootScope', '$q', 'fetch', ($rootScope, $q, fetch) ->
	poems = []
	heading = undefined

	@update = (config) ->
		fetch(config).then((result) ->
			$q.all(result.promises).then((results) ->
				poems = results
				heading = result.heading
				$rootScope.$emit "poemsLoaded"
			)
		)

	@get = () ->
		poems

	@getHeading = () ->
		heading

	@
]
