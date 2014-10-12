transformer = {}
english = {}
czech = {}
polish = {}
expected = {}

module "transformer", {
	setup: () ->
		transformer = injector.get "transformer"

		english = {
			meta: { Title: "Ten Commandments", Author: "God knows" }
			content: [
				{ section: "1", text: "Thou shalt have no other gods before me" }
				{ section: "2", text: "Thou shalt not take the name of the Lord thy God in vain" }
				{ section: "3", text: "Remember the sabbath day, to keep it holy" }
			]
		}

		czech = {
			meta: { Title: "Desatero", Author: "Ví bůh" }
			content: [
				{ section: "1", text: "V jednoho Boha věřiti budeš." }
				{ section: "2", text: "Nevezmeš jména Božího nadarmo." }
				{ section: "3", text: "Pomni, abys den sváteční světil." }
			]
		}

		polish = {
			meta: { Title: "Dekalog", Author: "Bóg wie" }
			content: [
				{ section: "1", text: "Nie będziesz miał bogów cudzych przede mną." }
				{ section: "2", text: "Nie będziesz wzywał imienia Boga twego nadaremno." }
				{ section: "3", text: "Pamiętaj, abyś dzień święty święcił." }
			]
		}

		expected = {
			meta: [
				{ Title: "Ten Commandments", Author: "God knows" }
				{ Title: "Desatero", Author: "Ví bůh" }
				{ Title: "Dekalog", Author: "Bóg wie" }
			]

			verses: [[
				{ section: "1", text: "Thou shalt have no other gods before me" }
				{ section: "1", text: "V jednoho Boha věřiti budeš." }
				{ section: "1", text: "Nie będziesz miał bogów cudzych przede mną." }
			], [
				{ section: "2", text: "Thou shalt not take the name of the Lord thy God in vain" }
				{ section: "2", text: "Nevezmeš jména Božího nadarmo." }
				{ section: "2", text: "Nie będziesz wzywał imienia Boga twego nadaremno." }
			], [
				{ section: "3", text: "Remember the sabbath day, to keep it holy" }
				{ section: "3", text: "Pomni, abys den sváteční světil." }
				{ section: "3", text: "Pamiętaj, abyś dzień święty święcił." }
			]]
		}
}

test "transforms", () ->
	deepEqual transformer([english, czech, polish]), expected

test "transforms with 2 items", () ->
	expected.meta = expected.meta.slice(0, 2)
	expected.verses = _.map(expected.verses, (translations) ->
		return translations.slice(0, 2)
	)
	deepEqual transformer([english, czech]), expected

test "throws error on no param", () ->
	throws () ->
		transformer()
	, /no poems found/i

test "throws error on empty array", () ->
	throws () ->
		transformer []
	, /no poems found/i

test "throws error on poem being too short", () ->
	czech.content.pop()
	throws () ->
		transformer [english, czech, polish]
	, /missing.*nevezmeš jména/i

test "throws error on poem being too long", () ->
	czech.content.pop()
	polish.content.pop()
	throws () ->
		transformer [english, czech, polish]
	, /superfluous.*sabbath/i

test "throws error on poems too short plus different lengths", () ->
	czech.content.pop()
	polish.content.pop()
	polish.content.pop()
	throws () ->
		transformer [english, czech, polish]
	, /missing.*bogów cudzych.*nevezmeš/i
