route = {}

module "route", {
	setup: () ->
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
}

test "has app url", () ->
	equal route.appUrl, 'http://example.com'

test "gets parameters", () ->
	deepEqual route.params, {
		'asdf': 'zxcv'
		'qwerty': 'asdf'
		'base': ''
	}

test "updates parameters", () ->
	route.update('asdf', 'hjkl')
	deepEqual route.params, {
		'asdf': 'hjkl'
		'qwerty': 'asdf'
		'base': ''
	}

test "adds parameter", () ->
	route.update('new', 'one')
	deepEqual route.params, {
		'asdf': 'zxcv'
		'qwerty': 'asdf'
		'base': ''
		'new': 'one'
	}
