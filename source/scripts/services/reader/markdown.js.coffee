angular.module("sideBySide").factory("markdownReader", ->
	# Read markdown poem
	#
	# For sample input, see:
	# source/documents/tests/services/reader/markdown.js.coffee
	#
	# @param source [String] Markdown poem
	# @return [Object] Poem object
	(source) ->
		# Read meta information from markdown block
		#
		# @param block [string] Meta block
		# @param inlineLexer [Object] Inline markdown lexer
		# @return [Object] Meta properties
		readMeta = (text, inlineLexer) ->
			meta = {}
			for line in text.split "\n"
				lexed = inlineLexer.output line
				match = /([^:]*):(.*)/.exec lexed
				meta[match[1].trim()] = match[2].trim()
			meta

		# Read and remove one section from start of lexed blocks
		#
		# @param lexed [Array] Lexed blocks
		# @return [Array] Section
		readSection = (lexed, separators) ->
			items = []
			while lexed.length > 0
				break if lexed[0]["type"] in separators
				items.push lexed.shift()
			items

		# Read content from lexed blocks
		#
		# @param lexed [Array] Lexed blocks
		# @param separators [Array] Section separators
		# @return [Array] Content
		readContent = (lexed, separators) ->
			content = []

			while lexed.length > 0
				heading = if lexed[0]["type"] in separators \
					then lexed.shift().text or "" \
					else ""

				text = readSection(lexed, separators)
				text.links = lexed.links
				content.push {
					section: heading
					text: marked.parser text
				}
			content

		marked.setOptions { smartypants: true }
		lexed = marked.lexer source
		meta = readMeta(lexed.shift().text, new marked.InlineLexer lexed.links)
		separators = if meta.Separator \
			then [meta.Separator] else ['heading', 'hr']

		{
			meta: meta
			content: readContent(lexed, separators)
		}
)
