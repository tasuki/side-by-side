angular.module("sideBySide").service "filter", ['poems', (poems) ->
	headers = []

	@update = () ->
		extractHeaders(poems.all)

	@getFilter = () ->
		for header in headers
			activeHeaderValues = _.uniq(poems.getActive().map((item) ->
				item.meta[header]
			))
			if (activeHeaderValues.length > 1)
				continue # header value differs

			inactiveMatching = poems.getInactive().filter((item) ->
				item.meta[header] == activeHeaderValues[0]
			)
			if (inactiveMatching.length > 0)
				continue # inactive poems have same header value

			ret = {}
			ret[header] = activeHeaderValues
			return ret

	extractHeaders = (all) ->
		fieldLengths = all
			.map (poem) ->
				poem.meta
			.reduce((fields, meta) ->
				for key, val of meta
					if typeof val == 'string'
						if key not of fields
							fields[key] = 0
						fields[key] += val.length
				fields
			, {})

		headers = _
			.sortBy((
				{ 'key': k, 'len': l } for k,l of fieldLengths
			), 'len')
			.map (item) ->
				item.key

	@
]
