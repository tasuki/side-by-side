# Side By Side

[![Build Status](https://travis-ci.org/tasuki/side-by-side.png?branch=master)](https://travis-ci.org/tasuki/side-by-side)

Easy visual comparison of different translations or versions of itemized texts;
e.g. poems, bibles, etc.

## Usage

Want to set up your own side by side comparison with minimal hassle?

See [the sample app](https://github.com/tasuki/sbs) with the instructions!

## Development

### Installation

Install nodejs, [probably 16+][bug] (worked with nodejs 18 from Ubuntu snaps in 2022).

[bug]: https://stackoverflow.com/questions/55921442/how-to-fix-referenceerror-primordials-is-not-defined-in-node-js

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
