angular.module("sideBySide").factory "fetch", ['$http', 'readerFactory', ($http, readerFactory) ->
	# Fetch
	#
	# @param file [String] Path to config file
	# @return [Object] Promises and heading
	(file = "/config.json") ->
		$http.get(file).then((response) ->
			promises = []
			for poem in response.data.files
				promises.push($http.get(poem).then((response) ->
					reader = readerFactory(poem)
					reader(response.data)
				))

			{
				promises: promises
				heading: response.data.heading
			}
		)
]
