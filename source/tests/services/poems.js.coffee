poems = {}

module "poems", {
	setup: () ->
		poems = getInjector().get 'poems'
}

setPoems = () ->
	poems.all = [{
		meta: { Active: true }
		content: [{ section: '1', text: 'one' }]
	}, {
		meta: { Active: false }
		content: [{ section: '2', text: 'two' }]
	}, {
		meta: { Active: true }
		content: [{ section: '3', text: 'three' }]
	}, {
		meta: { }
		content: [{ section: '4', text: 'four' }]
	}]

test "has default content", () ->
	active = poems.getActive()
	equal active[0].content[0].text, 'Please be patient!'
	equal active[0].content[0].section, 'Loading...'

test "gets active", () ->
	setPoems()
	active = poems.getActive()
	equal active[0].content[0].section, '1'
	equal active[1].content[0].section, '3'

test "gets inactive", () ->
	setPoems()
	inactive = poems.getInactive()
	equal inactive[0].content[0].section, '2'
	equal inactive[1].content[0].section, '4'
