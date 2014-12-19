poems = {}

module "poems", {
	setup: () ->
		angular.module("sideBySide").service("route", () ->
			@params = { 'display': 'asdf' }
		)
		poems = angular.injector(['ng', 'sideBySide']).get('poems')
}

test "has default content", () ->
	active = poems.getActive()
	equal active[0].content[0].text, 'Please be patient!'
	equal active[0].content[0].section, 'Loading...'

test "gets active", () ->
	poems.all = [{
		meta: { Active: true }
		content: [{ section: '1', text: 'one' }]
	}, {
		meta: { Active: false }
		content: [{ section: '2', text: 'two' }]
	}, {
		meta: { Active: true }
		content: [{ section: '3', text: 'three' }]
	}]

	active = poems.getActive()
	equal active[0].content[0].section, '1'
	equal active[1].content[0].section, '3'
