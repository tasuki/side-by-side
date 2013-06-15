angular.module("sideBySide").factory("markdownReader", () ->
	return (source) ->
		read_meta = (block, inlineLexer) ->
			meta = {}
			lexed = inlineLexer.output(block.text)
			for line in lexed.split("\n")
				match = /([^:]*):(.*)/.exec(line)
				meta[match[1].trim()] = match[2].trim()
			return meta

		read_content = (lexed) ->
			get_section = (lexed) ->
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

				text = get_section(lexed)
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
			meta: read_meta(meta, inlineLexer)
			content: read_content(lexed)
		}
)
