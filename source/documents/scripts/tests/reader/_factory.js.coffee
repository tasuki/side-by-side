test("readerFactory", () ->
	factory = injector.get("readerFactory")

	ok(factory("somefile.md"))
	ok(factory("otherfile.json"))
	throws(() ->
		factory("microsoft.doc")
	, /unknown/i)
)
