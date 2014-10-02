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
					for poem in results
						if not poem.meta.Active?
							poem.meta.Active = true
						poems.push poem

					heading = result.heading
					loaded = true

					$rootScope.$emit "poemsLoaded"
				)
			)

	@get = () ->
		poem for poem in poems when poem.meta.Active is true

	@getHeading = () ->
		heading

	@show = (id) ->
		poems[id].meta.Active = true

	@hide = (id) ->
		poems[id].meta.Active = false

	@
]
