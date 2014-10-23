default:
	npm install
	node_modules/.bin/grunt

run:
	node_modules/.bin/grunt connect

test:
	node_modules/.bin/phantomjs node_modules/qunitjs/addons/phantomjs/runner.js http://0.0.0.0:8000/tests.html

clean:
	rm -rf node_modules/ build/
