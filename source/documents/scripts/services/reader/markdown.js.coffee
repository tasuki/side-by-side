angular.module("sideBySide").factory("markdownReader", () ->
	# Read markdown poem
	#
	# For sample input, see:
	# source/documents/tests/services/reader/markdown.js.coffee
	#
	# @param source [String] Markdown poem
	# @return [Object] Poem object
	return (source) ->
		# Read meta information from markdown block
		#
		# @param block [string] Meta block
		# @param inlineLexer [Object] Inline markdown lexer
		# @return [Object] Meta properties
		readMeta = (text, inlineLexer) ->
			meta = {}
			for line in text.split("\n")
				lexed = inlineLexer.output(line)
				match = /([^:]*):(.*)/.exec(lexed)
				meta[match[1].trim()] = match[2].trim()
			return meta

		# Read and remove one section from start of lexed blocks
		#
		# @param lexed [Array] Lexed blocks
		# @return [Array] Section
		readSection = (lexed) ->
			items = []
			while lexed.length > 0
				break if lexed[0]["type"] == "heading"
				items.push(lexed.shift())
			return items

		# Read content from lexed blocks
		#
		# @param lexed [Array] Lexed blocks
		# @return [Array] Content
		readContent = (lexed) ->
			content = []

			while lexed.length > 0
				heading = if lexed[0]["type"] == "heading" \
					then lexed.shift().text \
					else heading = ''

				text = readSection(lexed)
				text.links = lexed.links
				content.push({
					section: heading
					text: marked.parser(text)
				})
			return content

		lexed = marked.lexer(source)
		meta = lexed.shift()
		meta = readMeta(meta.text, new marked.InlineLexer(lexed.links))

		return {
			meta: meta
			content: readContent(lexed)
		}
)
