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

	@load = (base = '') =>
		config = base.replace(/\./g, '/') + "/config.json"

		fetch(config).then (result) =>
			$q.all(result.promises).then (results) =>
				@all = []
				for poem in results
					if not poem.meta.Active?
						poem.meta.Active = true
					@all.push poem

				@heading = result.heading

	@
]
