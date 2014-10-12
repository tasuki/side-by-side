angular.module("sideBySide").factory "fetch", ['$http', 'readerFactory', ($http, readerFactory) ->
	# Fetch
	#
	# @param file [String] Path to config file
	# @return [Object] Promises and heading
	(file = "/config.json") ->
		$http.get(file).then (config) ->
			promises = config.data.files.map (poem) ->
				$http.get(poem).then (response) ->
					readerFactory(poem) response.data

			{
				promises: promises
				heading: config.data.heading
				active: config.data.active
			}
]
