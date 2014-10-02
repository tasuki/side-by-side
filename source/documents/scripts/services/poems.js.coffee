angular.module("sideBySide").service "poems", ['$rootScope', '$q', 'fetch', ($rootScope, $q, fetch) ->
	poems = []
	loaded = false
	heading = undefined

	@update = (config) ->
		if loaded == true
			$rootScope.$emit "poemsLoaded"
		else
			fetch(config).then((result) ->
				$q.all(result.promises).then((results) ->
					poems = results
					heading = result.heading
					loaded = true

					$rootScope.$emit "poemsLoaded"
				)
			)

	@get = () ->
		poems

	@getHeading = () ->
		heading

	@
]
