route = {}

module "route", {}

setup = (
	base = 'http://example.com'
	path = '/base:asdf/section:7'
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
	equal route.get(), 'base:asdf/section:7'

test "updates parameters", () ->
	setup()
	route.update('base', 'zxcv')
	equal route.get(), 'base:zxcv/section:7'

test "adds parameter", () ->
	setup('http://example.com', '/base:asdf')
	route.update('section', '1')
	equal route.get(), 'base:asdf/section:1'

test "processes arrays from url", () ->
	setup('http://example.com', '/display:Language:Czech,English', '')

	deepEqual route.params, {
		'base': ''
		'display': {
			'Language': [ 'Czech', 'English' ]
		}
	}

test "adds base before section", () ->
	setup('http://example.com', '/section:7', '')
	route.update('base', 'the_raven')
	equal route.get(), 'base:the_raven/section:7'
