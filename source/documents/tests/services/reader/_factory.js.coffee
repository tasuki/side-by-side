factory = {}

module "reader factory", {
	setup: () ->
		factory = injector.get "readerFactory"
}

test "reads markdown", () ->
	ok factory "somefile.md"
	ok factory "otherfile.markdown"

test "reads json", () ->
	ok factory "fried.json"

test "doesn't read doc", () ->
	throws () ->
		factory "microsoft.doc"
	, /unknown/i
