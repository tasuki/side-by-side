_ = require('lodash');
modRewrite = require('connect-modrewrite');
middleware = (connect, options) ->
	suffixes = ("\\." + suffix for suffix in [
		'html'
		'js'
		'css'
		'md'
		'json'
		'eot'
		'svg'
		'ttf'
		'woff'
		'woff2'
		'otf'
	]).join('|')

	[
		modRewrite(["!" + suffixes + "$ /index.html [L]"])
		connect.static(options.base[0])
	]

add = (subtasks, defaults = {}) ->
	subtasks.map((item) -> [
		item[0]
		_.extend {
			expand: true
			cwd: 'source'
			dest: if /^min/.test(item[0]) then 'build-min' else 'build'
		}, defaults, item[1]
	]).reduce((params, param) ->
		params[param[0]] = param[1]
		params
	, {})

get_base = (vars, min = false) ->
	if typeof(vars.base) == 'string'
		return vars.base
	return if min then '/sbs/' else '/'

module.exports = (grunt) ->
	vars = {
		scripts: [
			'bower_components/lodash/dist/lodash.js'
			'bower_components/angular/angular.js'
			'bower_components/angular-animate/angular-animate.js'
			'bower_components/angular-sanitize/angular-sanitize.js'
			'bower_components/angular-scroll/angular-scroll.js'
			'bower_components/ngDialog/js/ngDialog.js'
			'bower_components/marked/lib/marked.js'
			'scripts/app.js'
			'scripts/controllers/app.js'
			'scripts/controllers/comparison.js'
			'scripts/services/fetch.js'
			'scripts/services/filter.js'
			'scripts/services/load.js'
			'scripts/services/poems.js'
			'scripts/services/route.js'
			'scripts/services/transformer.js'
			'scripts/services/reader/_factory.js'
			'scripts/services/reader/json.js'
			'scripts/services/reader/markdown.js'
		]
		styles: [
			'bower_components/ngDialog/css/ngDialog.css'
			'bower_components/ngDialog/css/ngDialog-theme-default.css'
			'bower_components/pure/pure-min.css'
			'styles/fonts.css'
			'styles/style.css'
		]
		test_scripts: [
			'bower_components/qunit/qunit/qunit.js'
			'tests/_setup.js'
			'tests/services/filter.js'
			'tests/services/poems.js'
			'tests/services/route.js'
			'tests/services/transformer.js'
			'tests/services/reader/_factory.js'
			'tests/services/reader/json.js'
			'tests/services/reader/markdown.js'
		]
		test_styles: [
			'bower_components/qunit/qunit/qunit.css'
		]
		html5Mode: false
		min: false
	}

	watchconfigs = {
		main: {
			copy: {
				files: [ 'source/.htaccess', 'source/tests/the_raven/*' ]
				tasks: 'copy:main'
			}
			jade: {
				files: 'source/**/*.jade'
				tasks: 'jade:main'
			}
			coffee: {
				files: 'source/**/*.coffee'
				tasks: 'coffee:main'
			}
			stylus: {
				files: 'source/**/*.styl'
				tasks: 'stylus:main'
			}
		}
		min: {
			copy_min: {
				files: [ 'source/.htaccess', 'source/tests/the_raven/*' ]
				tasks: 'copy:min'
			}
			jade_min: {
				files: 'source/**/*.jade'
				tasks: 'jade:min'
			}
			css_min: {
				files: 'build/**/*.css'
				tasks: 'cssmin:min'
			}
			js_min: {
				files: 'build/**/*.js'
				tasks: 'uglify:min'
			}
		}
	}

	grunt.initConfig {
		pkg: grunt.file.readJSON 'package.json'

		connect: {
			main: {
				options: {
					base: 'build'
					middleware: middleware
				}
			}
			min: {
				options: {
					port: 8001
					base: 'build-min'
					middleware: middleware
				}
			}
		}

		cssmin: {
			min: {
				files: {
					'build-min/styles/all_min.css': ('build/' + style for style in vars.styles)
					'build-min/styles/test_min.css': ('build/' + style for style in vars.test_styles)
				}
			}
		}

		uglify: {
			min: {
				files: {
					'build-min/scripts/all_min.js': ('build/' + script for script in vars.scripts)
					'build-min/scripts/test_min.js': ('build/' + script for script in vars.test_scripts)
				}
			}
		}

		qunit: {
			main: {
				options: {
					urls: [
						'http://0.0.0.0:8000/tests.html'
					]
				}
			}
		}
	}

	grunt.config 'copy', add([
		[ 'main', {
			src: [ '.htaccess', 'tests/the_raven/*' ]
			options: {
				processContent: (content) ->
					grunt.template.process content, { data: {
						base: get_base(vars)
					}}
			}
		}]
		[ 'fonts', {
			src: ['fonts/*']
		}]
		[ 'min', {
			src: [ '.htaccess', 'tests/the_raven/*' ]
			options: {
				processContent: (content) ->
					grunt.template.process content, { data: {
						base: get_base(vars, true)
					}}
			}
		}]
		[ 'min_fonts', {
			src: ['fonts/*']
			dest: 'build-min/'
		}]
		[ 'min_readme', {
			cwd: ''
			src: 'README-USAGE.md'
			dest: 'build-min/'
			rename: (dest, src) ->
				dest + src.replace('-USAGE', '')
			options: {}
		}]
	])

	grunt.config 'jade', add([
		[ 'main', { options: {
			data: _.extend {}, vars, {
				base: get_base(vars)
				html5Mode: true
			}
			pretty: true
		}}]
		[ 'min', { options: {
			data: _.extend {}, vars, {
				min: true
				base: get_base(vars, true)
			}
			pretty: true
		}}]
	], {
		src: [ '*.jade', 'partials/**/*.jade' ]
		ext: '.html'
	})

	grunt.config 'coffee', add([['main', {
		src: '**/*.coffee'
		ext: '.js'
	}]])

	grunt.config 'stylus', add([['main', {
		src: '**/*.styl'
		ext: '.css'
		options: { compress: false }
	}]])

	# Load tasks
	grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.loadNpmTasks('grunt-contrib-connect');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-contrib-cssmin');
	grunt.loadNpmTasks('grunt-contrib-jade');
	grunt.loadNpmTasks('grunt-contrib-qunit');
	grunt.loadNpmTasks('grunt-contrib-stylus');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-watch');

	# Register tasks
	grunt.registerTask 'default', [ 'coffee:main', 'copy:main', 'copy:fonts', 'jade:main', 'stylus:main' ]
	grunt.registerTask 'min', [ 'jade:min', 'copy:min', 'copy:min_readme', 'copy:min_fonts', 'uglify:min', 'cssmin:min' ]
	grunt.registerTask 'test', [ 'default', 'connect:main', 'qunit' ]

	grunt.registerTask 'serve', () ->
		grunt.task.run 'default'
		grunt.task.run 'connect:main'
		grunt.config 'watch', watchconfigs.main
		grunt.task.run 'watch'

	grunt.registerTask 'serve-all', () ->
		grunt.task.run 'default'
		grunt.task.run 'min'
		grunt.task.run 'connect'
		grunt.config 'watch', _.extend {}, watchconfigs.main, watchconfigs.min
		grunt.task.run 'watch'
