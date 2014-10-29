module.exports = (grunt) ->
	grunt.initConfig {
		pkg: grunt.file.readJSON 'package.json'

		var: {
			source: 'source/documents'
			destination: 'build'
		}

		connect: {
			server: {
				options: {
					base: '<%= var.destination %>'
				}
			}
		}

		watch: {
			main: {
				files: '<%= var.source %>/**/*'
				tasks: ['default', 'qunit']
			}
			min: {
				files: [
					'<%= var.destination %>/scripts/**/*.js'
					'<%= var.destination %>/bower_components/**/*.js'
				]
				tasks: ['uglify']
			}
		}

		uglify: {
			main: {
				files: {
					'build/min/scripts.js': [
						'build/bower_components/lodash/dist/lodash.js'
						'build/bower_components/angular/angular.js'
						'build/bower_components/angular-route/angular-route.js'
						'build/bower_components/angular-sanitize/angular-sanitize.js'
						'build/bower_components/marked/lib/marked.js'
						'build/scripts/**/*.js'
					]
				}
			}
		}

		cssmin: {
			main: {
				files: {
					'build/min/styles.css': [
						'build/bower_components/fontawesome/css/font-awesome.min.css'
						'build/bower_components/pure/pure-min.css'
						'build/styles/**/*.css'
					]
				}
			}
		}

		copy: {
			main: {
				expand: true
				cwd: '<%= var.source %>'
				src: 'tests/the_raven/*'
				dest: '<%= var.destination %>'
			}
		}

		coffee: {
			main: {
				expand: true
				cwd: '<%= var.source %>'
				src: '**/*.coffee'
				dest: '<%= var.destination %>'
				ext: '.js'
			}
		}

		stylus: {
			main: {
				expand: true
				cwd: '<%= var.source %>'
				src: '**/*.styl'
				dest: '<%= var.destination %>'
				ext: '.css'
			}
		}

		jade: {
			main: {
				expand: true
				cwd: '<%= var.source %>'
				src: '**/*.jade'
				dest: '<%= var.destination %>'
				ext: '.html'
			}
		}

		qunit: {
			main: {
				options: {
					urls: [ 'http://0.0.0.0:8000/tests.html' ]
				}
			}
		}
	}

	grunt.loadNpmTasks('grunt-contrib-connect');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-cssmin');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.loadNpmTasks('grunt-contrib-stylus');
	grunt.loadNpmTasks('grunt-contrib-jade');
	grunt.loadNpmTasks("grunt-contrib-qunit");

	grunt.registerTask 'default', [ 'copy', 'coffee', 'stylus', 'jade' ]
	grunt.registerTask 'serve', [ 'default', 'connect', 'watch' ]
	grunt.registerTask 'test', [ 'default', 'connect', 'qunit' ]
