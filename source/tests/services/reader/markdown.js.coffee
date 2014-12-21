reader = {}

module "markdown reader", {
	setup: () ->
		reader = getInjector().get 'markdownReader'
}

test "loads poem with section numbers, paragraphs, and a list", () ->
	deepEqual reader("""
		Title: Universal Declaration of Human Rights
		Author: John Peters Humphrey
		Date: 1948
		Source: http://en.wikisource.org/wiki/Universal_Declaration_of_Human_Rights

		## 1
		All human beings are born *free* and equal in dignity and rights...

		## 2
		Everyone is entitled to all the rights and freedoms...

		Furthermore, no distinction shall be made on the basis of...

		## 11.1
		Everyone charged with a penal offence has the right to be presumed...

		## 11.2
		No one shall be held guilty of any penal offence...

		## 13
		Everyone is entitled to:

		- sex
		- drugs
		- rock & roll
	"""),
	{
		meta: {
			Title: "Universal Declaration of Human Rights"
			Author: "John Peters Humphrey"
			Date: "1948"
			Source: '<a href="http://en.wikisource.org/wiki/Universal_Declaration_of_Human_Rights">http://en.wikisource.org/wiki/Universal_Declaration_of_Human_Rights</a>'
		}
		content: [
			{ section: "1", text: "<p>All human beings are born <em>free</em> and equal in dignity and rights…</p>\n" }
			{ section: "2", text: """
				<p>Everyone is entitled to all the rights and freedoms…</p>
				<p>Furthermore, no distinction shall be made on the basis of…</p>\n""" }
			{ section: "11.1", text: "<p>Everyone charged with a penal offence has the right to be presumed…</p>\n" }
			{ section: "11.2", text: "<p>No one shall be held guilty of any penal offence…</p>\n" }
			{ section: "13", text: """
				<p>Everyone is entitled to:</p>
				<ul>
				<li>sex</li>
				<li>drugs</li>
				<li>rock &amp; roll</li>
				</ul>\n""" }
		]
	}

test "loads poem with leading text and mixed separators", () ->
	deepEqual reader("""
		Title: Test leading text and mixed separators

		**This** is leading text.
		# I
		First section.

		---
		Second section.
	"""),
	{
		meta: {
			Title: "Test leading text and mixed separators"
		}
		content: [
			{ section: "", text: "<p><strong>This</strong> is leading text.</p>\n" }
			{ section: "I", text: "<p>First section.</p>\n" }
			{ section: "", text: "<p>Second section.</p>\n" }
		]
	}

test "loads poem using a custom separator", () ->
	deepEqual reader("""
		Title: Separator test
		Separator: heading

		# I
		First section.

		---
		Second part.

		# II
		Second section.
	"""),
	{
		meta: {
			Title: "Separator test"
			Separator: "heading"
		}
		content: [
			{ section: "I", text: """
				<p>First section.</p>
				<hr>
				<p>Second part.</p>\n""" }
			{ section: "II", text: "<p>Second section.</p>\n" }
		]
	}
