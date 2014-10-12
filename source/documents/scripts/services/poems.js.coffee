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

	# Get active poems
	#
	# @return [Array] Active poems
	@getActive = () ->
		(poem for poem in @all when poem.meta.Active is true)

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
	@load = (base = '') =>
		fetch(base + "/config.json").then (config) =>
			$q.all(config.promises).then (results) =>
				@all = (activize(poem, config.active) for poem in results)
				@heading = config.heading

	@
]
