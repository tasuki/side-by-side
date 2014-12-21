angular.module("sideBySide").service "filter", ['poems', (poems) ->
	headers = []

	@update = () ->
		extractHeaders(poems.all)

	@getFilter = () ->
		encodings = []
		for header in headers
			activeHeaderValues = _.uniq(poems.getActive().map((item) ->
				item.meta[header]
			))
			inactiveMatching = poems.getInactive().filter((item) ->
				item.meta[header] in activeHeaderValues
			)
			if (inactiveMatching.length > 0)
				continue # inactive poems have same header value

			encodings.push({ 'header': header, 'values': activeHeaderValues })

		minlength = _.min(encodings.map((item) -> item.values.length))
		firstMin = _.first(encodings.filter((item) ->
			item.values.length == minlength
		))

		ret = {}
		ret[firstMin.header] = firstMin.values
		ret

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
