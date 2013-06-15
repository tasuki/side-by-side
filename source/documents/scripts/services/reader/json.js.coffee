angular.module("sideBySide").factory("jsonReader", () ->
	return (source) ->
		parsed = eval('(' + source + ')')

		new_content = []
		for verse in parsed.content
			if typeof(verse) == "string"
				new_content.push({ section: "", text: verse })
			else
				if "section" not of verse
					verse.section = ""
				new_content.push(verse)

		parsed.content = new_content
		return parsed
)
