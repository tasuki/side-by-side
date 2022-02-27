# Side By Side

[![Build Status](https://travis-ci.org/tasuki/side-by-side.png?branch=master)](https://travis-ci.org/tasuki/side-by-side)

Easy visual comparison of different translations or versions of itemized texts;
e.g. poems, bibles, etc.

## Usage

Want to set up your own side by side comparison with minimal hassle?

See [the sample app](https://github.com/tasuki/sbs) with the instructions!

## Development

### Installation

Install nodejs, eg. on Debian/Ubuntu:

	sudo apt-get install nodejs

Clone the project, go to project folder, and install dependencies:

	git clone git@github.com:tasuki/side-by-side.git
	cd side-by-side
	npm install

### Run dev server

	node_modules/.bin/grunt serve

Point your browser at http://0.0.0.0:8000/base:tests.the_raven/

### Tests

If you have the grunt dev server running, point your browser at
http://0.0.0.0:8000/tests.html. Otherwise, run tests with `npm test`.

### Package/release

To package, run `node_modules/.bin/grunt min`, the result will be in the
`build-min` directory. Copy that to https://github.com/tasuki/sbs

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
