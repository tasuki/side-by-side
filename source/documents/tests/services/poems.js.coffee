test("poems service has default content", () ->
	poems = injector.get("poems")
	active = poems.getActive()
	equal(active[0].content[0].text, 'Please be patient!')
	equal(active[0].content[0].section, 'Loading...')
)
