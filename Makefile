default:
	npm install
	node_modules/.bin/docpad generate

run:
	node_modules/.bin/docpad run

test:
	node_modules/.bin/phantomjs node_modules/qunitjs/addons/phantomjs/runner.js http://0.0.0.0:9778/tests.html

clean:
	rm -rf node_modules/ build/
