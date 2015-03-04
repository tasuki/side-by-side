# Side By Side

[![Build Status](https://travis-ci.org/tasuk/side-by-side.png?branch=master)](https://travis-ci.org/tasuk/side-by-side)

Visual comparison of different translations of itemized texts; e.g. poems,
bibles, etc.

## Usage

*TODO: Include info on nodeless usage.*

## Development

### Installation

Install nodejs, eg. on Debian/Ubuntu:

	sudo apt-get install nodejs

Clone the project, go to project folder, and install dependencies:

	git clone git@github.com:tasuk/side-by-side.git
	cd side-by-side
	npm install

### Run dev server

	node_modules/.bin/grunt serve

Point your browser at http://0.0.0.0:8000/base:tests.the_raven/

### Tests

If you have the grunt dev server running, point your browser at http://0.0.0.0:8000/tests.html.
Otherwise, run tests with `npm test`.

### Release

First, upgrade the version number in `package.json`. Commit the change, and create a zip file with the release:

	node_modules/.bin/grunt release
