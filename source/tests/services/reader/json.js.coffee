reader = {}

module "json reader", {
	setup: ->
		reader = getInjector().get 'jsonReader'
}

test "loads poem", ->
	deepEqual reader("""
		{
			meta: {
				Title: "Test leading text"
			},
			content: [
				"<p><strong>This</strong> is leading text.</p>",
				{ section: "I", text: "<p>First section.</p>" },
				{ section: "II", text: "<p>Second section.</p>" },
				{ text: "<p>Another section.</p>" },
			],
		}
	"""),
	{
		meta: {
			Title: "Test leading text"
		}
		content: [
			{ section: "", text: "<p><strong>This</strong> is leading text.</p>" }
			{ section: "I", text: "<p>First section.</p>" }
			{ section: "II", text: "<p>Second section.</p>" }
			{ section: "", text: "<p>Another section.</p>" }
		]
	}
