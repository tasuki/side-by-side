# Side By Side

Easy visual comparison of different translations or versions of itemized texts;
e.g. poems, bibles, etc.

## Set Up

All you need is a web server. Following are two examples, one using
[DigitalOcean](https://www.digitalocean.com/?refcode=145c195a4635) (referral
link, will give you extra credit when you sign up) virtual private server, or
on your local computer.

### DigitalOcean

Create an account and log in. Create a droplet, you can leave all the default
settings. Ssh in, install apache and unzip:

	sudo apt-get install apache2 unzip

Download and install side by side:

	cd /var/www
	rm -rf html
	wget https://github.com/tasuk/side-by-side/releases/download/v0.0.1/side-by-side.zip
	unzip side-by-side.zip
	mv side-by-side html

Point your browser at (replace DROPLET_IP with the actual droplet ip address):

	http://DROPLET_IP/#/base:tests.the_raven

Optionally, use apache rewrites to get rid of the hash: First, edit the
`/etc/apache2/apache2.conf` file, find the `<Directory /var/www/>` section and
change `AllowOverride None` to `AllowOverride All`. Then run the following
commands:

	a2enmod rewrite
	service apache2 restart

Now point your browser at:

	http://DROPLET_IP/base:tests.the_raven

### Local Installation

Here we will assume you use Apache on Linux on `localhost`, and that your
username is `user`, but the instructions shouldn't be difficult to alter to any
other OS and web server combination.

Put the `side-by-side` directory into `~/public_html/side-by-side/`.

You'll need to manually change two files. The first one is the `.htaccess`, in
which you need to set the RewriteBase to the path under which your web server
will display the directory:

	RewriteBase /~user/side-by-side/

> Note: if you're not using Apache, you'll have to set up redirects by
> yourself. The rule is simple: if the file exists, retrieve it, otherwise
> retrieve `index.html`.

The second file that needs altering is `index.html`, in which you need to
change the base tag to the same path as above:

	<base href="/~user/side-by-side/">

Now you can verify the installation works by visiting
http://localhost/~user/side-by-side/base:tests.the_raven/

## Sample Usage

In the project directory, create a file called `config.json` with the following
content:

	{
		"title": "The Road Not Taken",
		"files": [
			"the-road-not-taken/robert-frost.md",
			"the-road-not-taken/hana-zantovska.md",
			"the-road-not-taken/tomas-jacko.md"
		]
	}

Create a directory `the-road-not-taken`. In it, create a file called
`robert-frost.md` with the following content:

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

Now visit the website (without the base specified) and voilá...

## Options

*TODO*

## Source & License

https://github.com/tasuk/side-by-side

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
