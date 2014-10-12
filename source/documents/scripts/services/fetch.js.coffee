angular.module("sideBySide").factory "fetch", ['$http', 'readerFactory', ($http, readerFactory) ->
	# Fetch
	#
	# @param file [String] Path to config file
	# @return [Object] Promises and heading
	(file = "/config.json") ->
		$http.get(file).then((config) ->
			promises = []
			for poem in config.data.files
				promises.push($http.get(poem).then((response) ->
					reader = readerFactory(poem)
					reader(response.data)
				))

			{
				promises: promises
				heading: config.data.heading
				active: config.data.active
			}
		)
]
