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
	equal route.get(), 'asdf:zxcv/qwerty:asdf'

test "updates parameters", () ->
	setup()
	route.update('asdf', 'hjkl')
	equal route.get(), 'asdf:hjkl/qwerty:asdf'

test "adds parameter", () ->
	setup()
	route.update('new', 'one')
	equal route.get(), 'asdf:zxcv/qwerty:asdf/new:one'

test "processes arrays from url", () ->
	setup('http://example.com', '/display:Language:Czech,English', '')

	deepEqual route.params, {
		'base': ''
		'display': {
			'Language': [ 'Czech', 'English' ]
		}
	}
