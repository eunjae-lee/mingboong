module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		coffeelint:
			options:
				max_line_length:
					value: 120
					level: "warn"
			app: ['public_src/coffeescripts/**/*.coffee']
		coffee:
			dev:
				options:
					bare: true
				files: [
					expand: true
					cwd: 'public_src/coffeescripts'
					src: ['**/*.coffee']
					dest: 'public/javascripts/'
					ext: '.js'
				]
		uglify:
			options:
				banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
			build:
				cwd: 'public/javascripts'
				src: ['**/*.js']
				dest: 'public/javascripts'
				ext: '.min.js'
		watch:
			options:
				livereload: true
			coffee:
				files: 'public_src/coffeescripts/**/*.coffee'
				tasks: ['coffee:dev']
			less:
				files: 'public_src/less/**/*.less'
				tasks: ['less:dev']
		less:
			dev:
				expand: true
				cwd: 'public_src/less'
				src: ['**/*.less']
				dest: 'public/stylesheets'
				ext: '.css'

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-coffeelint'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-less'

	grunt.registerTask 'default', ['coffeelint', 'coffee:dev', 'less:dev']