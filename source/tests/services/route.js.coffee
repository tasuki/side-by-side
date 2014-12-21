route = {}

module "route", {}

setup = (
	base = 'http://example.com'
	path = '/asdf:zxcv/qwerty:asdf'
	hash = '#test'
) ->
	angular.module("sideBySide").service("$location", () ->
		@path = () -> path
		@url = () -> path + hash
		@absUrl = () -> base + path + hash
		@
	)
	route = getInjector().get 'route'

test "has app url", () ->
	setup()
	equal route.appUrl, 'http://example.com'

test "gets parameters", () ->
	setup()
	deepEqual route.params, {
		'asdf': 'zxcv'
		'qwerty': 'asdf'
		'base': ''
	}

test "updates parameters", () ->
	setup()
	route.update('asdf', 'hjkl')
	deepEqual route.params, {
		'asdf': 'hjkl'
		'qwerty': 'asdf'
		'base': ''
	}

test "adds parameter", () ->
	setup()
	route.update('new', 'one')
	deepEqual route.params, {
		'asdf': 'zxcv'
		'qwerty': 'asdf'
		'base': ''
		'new': 'one'
	}

test "gets arrays", () ->
	setup('http://example.com', '/display:Language:Czech,English', '')

	deepEqual route.params, {
		'base': ''
		'display': {
			'Language': [ 'Czech', 'English' ]
		}
	}
