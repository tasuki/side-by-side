angular.module("sideBySide").factory("transformer", () ->
	# Transform translations
	#
	# @param translations [...Object] Translation with 'meta' and 'content' keys
	# @throw No poems or uneven number of verses
	# @return [Array] Translations transformed into row-based format
	return (translations...) ->
		# Check whether all translations have same number of verses
		#
		# @param translations [array] Translations to check
		check_lengths = (translations) ->
			if translations.length < 1
				throw "No poems found!"
			lengths = []
			for translation in translations
				l = translation.content.length
				lengths[l] = 0 if l not of lengths
				lengths[l]++

			# return if all are same length
			return if _.size(_.compact(lengths)) <= 1

			uneven = (count + " of length " + length \
				for count,length in lengths \
				when typeof count isnt "undefined")

			details = []
			while _.size(_.compact(lengths)) > 1
				mindex = _.indexOf(lengths, _.min(lengths))
				maxdex = _.indexOf(lengths, _.max(lengths))

				# least occuring count is higher than most occuring count 
				message = if mindex > maxdex \
					then "Superfluous verses: " \
					else "Missing verses after: "

				# get last verses of translations with mindex verses
				lastVerses = _.map(translations.filter((translation) ->
					return translation.content.length == mindex
				), (translation) ->
					return "'" + _.last(translation.content).text + "'"
				)

				details.push(message + lastVerses.join(", "))

				# remove least occuring from lengths
				delete lengths[mindex]

			throw "Poems with uneven number of verses: " +
				uneven.join(", ") + "." +
				" (" + details.join("; ") + ")."


		check_lengths(translations)

		data = {
			meta: []
			verses: []
		}

		data.meta.push(translation.meta) for translation in translations

		id = 0
		while true
			versions = []
			found = false
			for translation in translations
				if translation.content.length > id
					found = translation.content[id]
					versions.push(found)

			if found == false
				break

			data.verses.push(versions)
			id++

		return data
)
