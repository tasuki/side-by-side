_ = require('lodash');

module.exports = (grunt) ->
	vars = {
		scripts: [
			'bower_components/lodash/dist/lodash.js'
			'bower_components/angular/angular.js'
			'bower_components/angular-route/angular-route.js'
			'bower_components/angular-sanitize/angular-sanitize.js'
			'bower_components/marked/lib/marked.js'
			'scripts/app.js'
			'scripts/services/fetch.js'
			'scripts/services/poems.js'
			'scripts/services/reader/_factory.js'
			'scripts/services/reader/markdown.js'
			'scripts/services/reader/json.js'
			'scripts/services/transformer.js'
			'scripts/controllers.js'
		]
		styles: [
			'bower_components/fontawesome/css/font-awesome.min.css'
			'bower_components/pure/pure-min.css'
			'styles/style.css'
		]
		test_scripts: [
			'bower_components/qunit/qunit/qunit.js'
			'tests/_setup.js'
			'tests/services/reader/_factory.js'
			'tests/services/reader/markdown.js'
			'tests/services/reader/json.js'
			'tests/services/transformer.js'
			'tests/services/poems.js'
		]
		test_styles: [
			'bower_components/qunit/qunit/qunit.css'
		]
		min: false
	}

	watchconfigs = {
		main: {
			coffee: {
				files: 'source/**/*.coffee'
				tasks: 'coffee:main'
			}
			test: {
				files: 'source/tests/the_raven/*'
				tasks: 'copy:main_raven'
			}
			jade: {
				files: 'source/**/*.jade'
				tasks: 'jade:main'
			}
			stylus: {
				files: 'source/**/*.styl'
				tasks: 'stylus:main'
			}
		}
		min: {
			test_min: {
				files: 'source/tests/the_raven/*'
				tasks: 'copy:min_raven'
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
				tasks: 'uglify'
			}
		}
	}

	grunt.initConfig {
		pkg: grunt.file.readJSON 'package.json'

		coffee: {
			main: {
				expand: true
				cwd: 'source'
				src: '**/*.coffee'
				dest: 'build'
				ext: '.js'
			}
		}

		connect: {
			main: {
				options: {
					base: 'build'
				}
			}
			min: {
				options: {
					port: 8001
					base: 'build-min'
				}
			}
		}

		copy: {
			main_raven: {
				expand: true
				cwd: 'source'
				src: 'tests/the_raven/*'
				dest: 'build'
			}
			min_raven: {
				expand: true
				cwd: 'source'
				src: 'tests/the_raven/*'
				dest: 'build-min'
			}
			min_fonts: {
				expand: true
				cwd: 'build/bower_components/fontawesome/fonts'
				src: '*'
				dest: 'build-min/fonts/'
			}
		}

		cssmin: {
			min: {
				files: {
					'build-min/styles/styles.css': ('build/' + style for style in vars.styles)
					'build-min/styles/test_styles.css': ('build/' + style for style in vars.test_styles)
				}
			}
		}

		jade: {
			main: {
				expand: true
				cwd: 'source'
				src: '**/*.jade'
				dest: 'build'
				ext: '.html'
				options: {
					data: vars
					pretty: true
				}
			}
			min: {
				expand: true
				cwd: 'source'
				src: '**/*.jade'
				dest: 'build-min'
				ext: '.html'
				options: {
					data: _.extend {}, vars, { min: true }
				}
			}
		}

		qunit: {
			main: {
				options: {
					urls: [
						'http://0.0.0.0:8000/tests.html'
						'http://0.0.0.0:8001/tests.html'
					]
				}
			}
		}

		stylus: {
			main: {
				expand: true
				cwd: 'source'
				src: '**/*.styl'
				dest: 'build'
				ext: '.css'
			}
		}

		uglify: {
			min: {
				files: {
					'build-min/scripts/scripts.js': ('build/' + script for script in vars.scripts)
					'build-min/scripts/test_scripts.js': ('build/' + script for script in vars.test_scripts)
				}
			}
		}
	}

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
	grunt.registerTask 'default', [ 'coffee:main', 'copy:main_raven', 'jade:main', 'stylus:main' ]
	grunt.registerTask 'min', [ 'jade:min', 'copy:min_raven', 'copy:min_fonts', 'uglify:min', 'cssmin:min' ]
	grunt.registerTask 'test', [ 'default', 'min', 'connect', 'qunit' ]

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
