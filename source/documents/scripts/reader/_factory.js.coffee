angular.module("sideBySide").factory("readerFactory", ($injector) ->
	return (filename) ->
		extension = filename.split(".").pop()
		switch extension
			when "json"
				return $injector.get("jsonReader")
			when "md", "markdown"
				return $injector.get("markdownReader")
			else
				throw "Unknown extension '" + extension + "'."
)
