angular.module("sideBySide").factory("jsonReader", () ->
	return (source) ->
		parsed = eval('(' + source + ')')

		newContent = []
		for verse in parsed.content
			if typeof(verse) == "string"
				newContent.push({ section: "", text: verse })
			else
				if "section" not of verse
					verse.section = ""
				newContent.push(verse)

		parsed.content = newContent
		return parsed
)
