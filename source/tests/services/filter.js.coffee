poems = {}
filter = {}
poemList = {}

module "filter", {
	setup: ->
		injector = getInjector()
		poems = injector.get('poems')
		filter = injector.get('filter')
}

setPoems = ->
	poemList.poe = { meta: {
		Active: false
		Author: 'Edgar Allan Poe'
		Title: 'The Raven'
		Year: '1845'
		Language: 'English'
		Code: 'poe'
	}}
	poemList.vrch = { meta: {
		Active: false
		Author: 'Jaroslav Vrchlický'
		Title: 'Havran'
		Year: '1845'
		Language: 'Czech'
		Code: 'vrch'
	}}
	poemList.muz = { meta: {
		Active: false
		Author: 'Augustin Eugen Mužík'
		Title: 'Havran'
		Year: '1885'
		Language: 'Czech'
		Code: 'muz'
	}}
	poemList.dolu = { meta: {
		Active: false
		Author: 'Karel Dostál Lutinov'
		Title: 'Havran'
		Year: '1918'
		Language: 'Czech'
		Code: 'dolu'
	}}

	poems.all = [
		poemList.poe
		poemList.vrch
		poemList.muz
		poemList.dolu
	]

test "get filter for poems that share a common property", ->
	setPoems()
	poemList.dolu.meta.Active = true
	poemList.vrch.meta.Active = true
	poemList.muz.meta.Active = true
	filter.update()

	deepEqual filter.getFilter(), {
		'Language': [ 'Czech' ]
	}

test "get filter for arbitrary poems using shortest key", ->
	setPoems()
	poemList.vrch.meta.Active = true
	poemList.muz.meta.Active = true
	filter.update()

	deepEqual filter.getFilter(), {
		'Code': [ 'vrch', 'muz' ]
	}

test "set filter", ->
	setPoems()
	poemList.vrch.meta.Active = true
	filter.update()
	filter.setFilter {
		'Language': [ 'English' ]
	}

	equal poemList.vrch.meta.Active, false
	equal poemList.poe.meta.Active, true
	deepEqual filter.getFilter(), {
		'Code': [ 'poe' ]
	}
