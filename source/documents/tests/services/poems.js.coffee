poems = {}

module "poems", {
	setup: () ->
		poems = injector.get "poems"
}

test "has default content", () ->
	active = poems.getActive()
	equal active[0].content[0].text, 'Please be patient!'
	equal active[0].content[0].section, 'Loading...'
