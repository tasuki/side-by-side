angular.module("sideBySide").factory "load",
['filter', 'fetch', 'poems', (filter, fetch, poems) ->
	# Load poems
	#
	# @param base [String] Path to config file directory
	# @param display [Object] Eg: { Language: [ 'English', 'Czech' ] }
	(base, display) ->
		# Activize poem based on passed rules
		#
		# @param poem [Object]
		# @param display [Object] { meta: [ 'active', 'values' ] }
		# @return poem
		activize = (poem, display) ->
			poem.meta.Active = true if !display

			for metaKey,values of display
				poem.meta.Active = true if poem.meta[metaKey] in values

			poem

		fetch(base).then (config) ->
			config.fetchedPoems.then (poemList) ->
				disp = display or config.data.display
				poems.all = (activize(poem, disp) for poem in poemList)
				poems.heading = config.data.heading
				filter.update()
]
