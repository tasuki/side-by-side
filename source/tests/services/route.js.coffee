route = {}

module "route", {}

simpleSetup = () ->
	angular.module("sideBySide").service("$location", () ->
		@path = () ->
			'/asdf:zxcv/qwerty:asdf'
		@url = () ->
			'/asdf:zxcv/qwerty:asdf#test'
		@absUrl = () ->
			'http://example.com/asdf:zxcv/qwerty:asdf#test'
		@
	)
	route = angular.injector(['ng', 'sideBySide']).get('route')

test "has app url", () ->
	simpleSetup()
	equal route.appUrl, 'http://example.com'

test "gets parameters", () ->
	simpleSetup()
	deepEqual route.params, {
		'asdf': 'zxcv'
		'qwerty': 'asdf'
		'base': ''
	}

test "updates parameters", () ->
	simpleSetup()
	route.update('asdf', 'hjkl')
	deepEqual route.params, {
		'asdf': 'hjkl'
		'qwerty': 'asdf'
		'base': ''
	}

test "adds parameter", () ->
	simpleSetup()
	route.update('new', 'one')
	deepEqual route.params, {
		'asdf': 'zxcv'
		'qwerty': 'asdf'
		'base': ''
		'new': 'one'
	}

test "gets arrays", () ->
	angular.module("sideBySide").service("$location", () ->
		urlPath = '/display:Language:Czech,English'
		@path = () ->
			urlPath
		@url = () ->
			urlPath
		@absUrl = () ->
			'http://example.com/' + urlPath
		@
	)
	route = angular.injector(['ng', 'sideBySide']).get('route')

	deepEqual route.params, {
		'base': ''
		'display': {
			'Language': [ 'Czech', 'English' ]
		}
	}
