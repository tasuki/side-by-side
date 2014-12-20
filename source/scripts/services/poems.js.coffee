angular.module("sideBySide").service "poems", ['fetch', 'route', (fetch, route) ->
	@all = [{
		meta: {
			Active: true
			Loading: "Loading"
		}
		content: [{
			section: 'Loading...'
			text: 'Please be patient!'
		}]
	}]
	@heading = undefined

	# Get active poems
	#
	# @return [Array] Active poems
	@getActive = () ->
		(poem for poem in @all when poem.meta.Active is true)

	# Get inactive poems
	#
	# @return [Array] Inactive poems
	@getInactive = () ->
		(poem for poem in @all when poem.meta.Active is not true)

	# Activize poem based on passed rules
	#
	# @param poem [Object]
	# @param active [Object] { meta: [ 'active', 'values' ] }
	# @return poem
	activize = (poem, active) ->
		poem.meta.Active = true if !active

		for metaKey,values of active
			poem.meta.Active = true if poem.meta[metaKey] in values

		poem

	# Load poems
	#
	# @param base [String]
	@load = (base) =>
		fetch(base).then (config) =>
			config.fetchPoems.then (poems) =>
				display = route.params.display or config.display
				@all = (activize(poem, display) for poem in poems)
				@heading = config.heading

	@
]
