angular.module("sideBySide").service "route", ['$location', ($location) ->
	@params = $location.path()
		.split('/')
		.filter((item) -> item)
		.map (item) ->
			item.split(':')
		.reduce((params, param) ->
			key = param.shift()

			if (param.length > 1)
				value = {}
				value[param[0]] = param[1].split(',')
			else
				value = param[0]

			params[key] = value
			params
		, {})

	@params.base = '' if 'base' not of @params

	@appUrl = $location.absUrl()
		.substring(0, $location.absUrl().length - $location.url().length)

	getValue = (value) ->
		if (typeof value == 'object')
			for key, val of value
				# only works for one key...
				return key + ":" + val.join(',')
		value

	@get = () ->
		(property + ':' + getValue(value) \
			for property, value of @params when value)
		.join('/')

	@update = (key, value) ->
		@params[key] = value
		$location.path @get()

	@
]
