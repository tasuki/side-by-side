angular.module("sideBySide").service "route",
['$location', ($location) ->
	@params = $location.path()
		.split '/'
		.filter (item) -> item
		.map (item) -> item.split ':'
		.reduce (params, param) ->
			key = param.shift()

			if param.length > 1
				value = {}
				value[param[0]] = param[1].split ','
			else
				value = param[0]

			params[key] = value
			params
		, {}

	@params.base = '' if 'base' not of @params

	absUrl = $location.absUrl()
	@appUrl = absUrl
		.substring(0, absUrl.length - $location.url().length)
		.replace /\/?#?$/, '' # remove / and # at string end

	getValue = (value) ->
		if typeof value == 'object'
			for key, val of value
				# only works for one key...
				return key + ":" + val.join ','
		value

	@get = ->
		['base', 'display', 'section']
			.filter (key) => @params[key]
			.map (key) =>
				key + ':' + getValue @params[key]
			.join '/'


	@getBaseDir = ->
		base = '/'
		if @params.base
			base += @params.base.replace(/\./g, '/') + '/'
		@appUrl + base

	@update = (key, value) ->
		@params[key] = value
		$location.path @get()

	@
]
