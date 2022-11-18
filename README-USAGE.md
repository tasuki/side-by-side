# Side By Side

Easy visual comparison of different translations or versions of itemized texts;
e.g. poems, bibles, etc.

This repository is the build artifact of https://github.com/tasuki/side-by-side  
See sample application at https://tasuki.github.io/sbs/#/base:tests.the_raven

## Quick start — Set up

[Fork] this very [repository]. When you push to the repository, a site should
appear at https://username.github.io/sbs/, where _username_ is your github
username.

[fork]: https://help.github.com/articles/fork-a-repo/
[repository]: https://github.com/tasuki/sbs

### Basic usage

In the project directory, [create a file] called `config.json` with the
following content:

[create a file]: https://help.github.com/articles/creating-new-files/

	{
		"title": "The Road Not Taken",
		"files": [
			"the-road-not-taken/robert-frost.md",
			"the-road-not-taken/hana-zantovska.md",
			"the-road-not-taken/tomas-jacko.md"
		]
	}

Then create a file `the-road-not-taken/robert-frost.md` with the following
content:

	Title: The Road Not Taken  
	Author: Robert Frost  
	Year: 1916  
	Language: English  
	
	Two roads diverged in a yellow wood,  
	And sorry I could not travel both  
	And be one traveler, long I stood  
	And looked down one as far as I could  
	To where it bent in the undergrowth;  
	
	---
	Then took the other, as just as fair  
	And having perhaps the better claim,  
	Because it was grassy and wanted wear;  
	Though as for that the passing there  
	Had worn them really about the same,  
	
	---
	And both that morning equally lay  
	In leaves no step had trodden black.  
	Oh, I kept the first for another day!  
	Yet knowing how way leads on to way,  
	I doubted if I should ever come back.  
	
	---
	I shall be telling this with a sigh  
	Somewhere ages and ages hence:  
	Two roads diverged in a wood, and I —  
	I took the one less traveled by,  
	And that has made all the difference.  

Next to it, create another file called `hana-zantovska.md`:

	Title: Nezvolená cesta  
	Author: Hana Žantovská  
	Year: 1983  
	Language: Czech  
	
	Dvě cesty se dělily v žlutém háji  
	a byl bych tak rád nelenil,  
	šel oběma a zvěděl, co tají,  
	tu první jsem sledoval očima, dal jí  
	sbohem, když zmizela v zeleni.  
	
	---
	Šel po druhé, která se nabízela,  
	snad právem jsem jí přednost dal,  
	zarostla travou, prošlápnout chtěla,  
	tu první mi pak připoměla,  
	když jsem ji poctivě prošlapal.  
	
	---
	Jedna i druhá zde zasypaná  
	ležely pokojně pod listím.  
	Tu první jsem zamýšlel pro jiná rána,  
	však každá cest je předešlou daná,  
	a sotva kdy se tam navrátím.  
	
	---
	Po létech povím to najednou  
	s povzdechem, jak čas plyne.  
	Dvě cesty se dělily, já šel tou,  
	kde jich šlo méně přede mnou  
	a pak bylo všechno jiné.  

And one more, called `tomas-jacko.md`:

	Title: Cesta, jíž jsem nešel  
	Author: Tomáš Jacko  
	Year: 2010  
	Language: Czech  
	
	Dvě pěšiny les ukrýval  
	a já se nemoh rozdvojit  
	a projít obě. Tak jsem stál  
	a dlouze jednu sledoval,  
	jak v dálce mizí ve chvojí.  
	
	---
	Pak jsem šel druhou z nich. Ta snad,  
	byť o nic horší, travinou  
	si zasloužila prošlapat —  
	ač rozdíl byl jen sotva znát,  
	vždyť tráva rostla na obou  
	
	---
	a obě shodně toho dne  
	tam vedly listím spadaným.  
	Ta první počká, nebo ne?  
	Však spleti cest jsou bezedné:  
	Já tušil, že se nevrátím.  
	
	---
	Až dlouhé roky uplynou,  
	tu kdesi řeknu s povzdechem:  
	Dvě cesty, les — a já šel tou  
	jen o trochu víc zarostlou.  
	A proto dneska jsem, kde jsem.  

Now visit https://username.github.io/sbs — you should see the site with a basic
comparison of these three versions of the poem.

> Note: You can pick a project name and [rename your repository]. After that,
> edit the `index.html` file and change the html base:
> `<base href="/your-project-name/">`.

[rename your repository]: https://help.github.com/articles/renaming-a-repository/

## Self hosting; advanced options

You can [download the build] and set it up on your own web server. There are no
dynamic parts, a static server is enough. Don't forget to set the appropriate
`base` in `index.html`.

[download the build]: https://github.com/tasuki/sbs/archive/gh-pages.zip

### Pretty urls — HTML5 mode

To get rid of the hash in the url:

1. Edit `index.html` and change `<script>html5Mode=false;</script>` to
   `<script>html5Mode=true;</script>`.
2. Make the web server redirect any requests for which the file doesn't exist
   to `index.html`. For apache, there's a `.htaccess` file included. Please
   note you need to change its `RewriteBase`.

## Source & License

https://github.com/tasuki/side-by-side

Copyright (c) 2015 Vít Brunner

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
