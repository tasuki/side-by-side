angular.module("sideBySide").service "poems", ['$q', 'fetch', ($q, fetch) ->
	@all = [{
		meta: {
			Active: true
		}
		content: [{
			section: 'Loading...'
			text: 'Please be patient!'
		}]
	}]
	@heading = undefined

	@getActive = () ->
		(poem for poem in @all when poem.meta.Active is true)

	activize = (poem, active) ->
		if !active
			poem.meta.Active = true

		for metaKey,values of active
			if poem.meta[metaKey] in values
				poem.meta.Active = true
		poem

	@load = (base = '') =>
		fetch(base + "/config.json").then (config) =>
			$q.all(config.promises).then (results) =>
				@all = []
				for poem in results
					@all.push activize(poem, config.active)

				@heading = config.heading

	@
]
