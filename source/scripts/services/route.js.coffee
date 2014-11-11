angular.module("sideBySide").service "route", ['$location', ($location) ->
	@params = $location.url()
		.split('/')
		.filter((item) -> item)
		.map (item) ->
			item.split(':')
		.reduce((params, param) ->
			params[param[0]] = param[1]
			params
		, {})

	@params.base = '' if 'base' not of @params
	@params.base = @params.base.replace(/\./g, '/')

	@appUrl = $location.absUrl()
		.substring(0, $location.absUrl().length - $location.url().length)
]
