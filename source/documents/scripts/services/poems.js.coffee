angular.module("sideBySide").service "poems", ['$rootScope', '$q', 'fetch', ($rootScope, $q, fetch) ->
	poems = []
	loaded = false
	heading = undefined

	@load = (base = '') ->
		config = base.replace(/\./g, '/') + "/config.json"

		if loaded == true
			$rootScope.$emit "poemsUpdated"
		else
			fetch(config).then((result) ->
				$q.all(result.promises).then((results) ->
					for poem in results
						if not poem.meta.Active?
							poem.meta.Active = true
						poems.push poem

					heading = result.heading
					loaded = true

					$rootScope.$emit "poemsUpdated"
				)
			)

	@get = () ->
		poem for poem in poems when poem.meta.Active is true

	@getHeading = () ->
		heading

	@show = (id) ->
		poems[id].meta.Active = true
		$rootScope.$emit "poemsUpdated"


	@hide = (id) ->
		poems[id].meta.Active = false
		$rootScope.$emit "poemsUpdated"

	@
]
