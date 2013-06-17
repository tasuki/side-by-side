angular.module("sideBySide").factory "fetch", ['$http', 'readerFactory', ($http, readerFactory) ->
	# Fetch
	#
	# @param file [String] Path to config file
	# @return TODO
	return (file = "config.json") ->
		$http.get(file).then((response) ->
			promises = []
			for poem in response.data.files
				promises.push($http.get(poem).then((response) ->
					reader = readerFactory(poem)
					return reader(response.data)
				))
			return promises
		)
]
