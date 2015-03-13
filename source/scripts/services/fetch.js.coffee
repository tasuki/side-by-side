angular.module("sideBySide").factory "fetch",
['$http', '$q', 'readerFactory'
($http, $q, readerFactory) ->
	# Fetch
	#
	# @param base [String] Path to config file directory
	# @return [Object] Promises and config data
	(base) ->
		file = base + 'config.json'
		$http.get(file).then (config) ->
			if typeof config.data != "object"
				throw "Config file " + file + " doesn't contain data."

			if typeof config.data.files != "object"
				throw "Config doesn't contain a list of files."

			promises = config.data.files.map (poem) ->
				$http.get(base + '/' + poem).then (response) ->
					readerFactory(poem) response.data

			{
				fetchedPoems: $q.all promises
				data: config.data
			}
]
