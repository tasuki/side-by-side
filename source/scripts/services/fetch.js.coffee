angular.module("sideBySide").factory "fetch",
['$http', '$q', 'readerFactory'
($http, $q, readerFactory) ->
	# Fetch
	#
	# @param base [String] Path to config file directory
	# @return [Object] Promises and config data
	(base) ->
		file = base + '/config.json'
		$http.get(file).then (config) ->
			promises = config.data.files.map (poem) ->
				$http.get(base + '/' + poem).then (response) ->
					readerFactory(poem) response.data

			{
				fetchedPoems: $q.all promises
				data: config.data
			}
]
