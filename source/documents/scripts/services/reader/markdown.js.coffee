angular.module("sideBySide").factory("markdownReader", () ->
	return (source) ->
		readMeta = (block, inlineLexer) ->
			meta = {}
			lexed = inlineLexer.output(block.text)
			for line in lexed.split("\n")
				match = /([^:]*):(.*)/.exec(line)
				meta[match[1].trim()] = match[2].trim()
			return meta

		readContent = (lexed) ->
			getSection = (lexed) ->
				items = []
				while lexed.length > 0
					if lexed[0]["type"] == "heading"
						break
					items.push(lexed.shift())
				return items

			content = []

			while lexed.length > 0
				if lexed[0]["type"] == "heading"
					heading = lexed.shift().text
				else
					heading = ''

				text = getSection(lexed)
				text.links = lexed.links
				content.push({
					section: heading
					text: marked.parser(text)
				})

			return content

		lexed = marked.lexer(source)
		meta = lexed.shift()
		inlineLexer = new marked.InlineLexer(lexed.links)

		return {
			meta: readMeta(meta, inlineLexer)
			content: readContent(lexed)
		}
)
