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

	@update = (key, value) ->
		@params[key] = value
		$location.path (property + ':' + value for property, value of @params).join('/')

	@
]
