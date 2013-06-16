angular.module("sideBySide").factory("jsonReader", () ->
	# Read json poem
	#
	# For sample input, see:
	# source/documents/tests/services/reader/json.js.coffee
	#
	# @param source [String] Json poem
	# @return [Object] Poem object
	return (source) ->
		parsed = eval('(' + source + ')')

		for i,verse of parsed.content
			if typeof(verse) == "string"
				parsed.content[i] = { section: "", text: verse }
			else
				verse.section = "" if "section" not of verse
				parsed.content[i] = verse

		return parsed
)
