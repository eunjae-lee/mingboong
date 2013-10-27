module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		coffeelint:
			options:
				max_line_length:
					value: 120
					level: "warn"
				no_trailing_whitespace:
					level: "warn"
			app: ['public/coffeescripts/**/*.coffee']
		coffee:
      dev:
        expand: true
        cwd: 'public/coffeescripts'
        src: ['**/*.coffee']
        dest: 'public_built/javascripts'
        ext: '.js'
		watch:
			options:
				livereload: true
			coffee:
				files: 'public/coffeescripts/**/*.coffee'
				tasks: ['coffee:dev']
			js:
				files: 'public/javascripts/**/*.coffee'
				tasks: ['copy:js']
			#images:
			#	files: 'public/images/**/*'
			#	tasks: ['copy:images']
			views:
				files: 'views/**/*'
				tasks: ['default']
			less:
				files: 'public/less/**/*.less'
				tasks: ['less:dev']
		less:
			dev:
				expand: true
				cwd: 'public/less'
				src: ['**/*.less']
				dest: 'public_built/stylesheets'
				ext: '.css'
		imagemin:
			comp:
				files: [{
					expand: true
					cwd: 'public/images/'
					src: ['**/*.{png,jpg,jpeg,gif}']
					dest: 'public_built/images'
				}]
		copy:
			js:
				cwd: 'public/javascripts/'
				src: '**/*'
				dest: 'public_built/javascripts'
				expand: true
			images:
				cwd: 'public/images/'
				src: '**/*'
				dest: 'public_built/images'
				expand: true

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-coffeelint'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-less'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-imagemin'

	grunt.registerTask 'default', ['coffeelint', 'coffee:dev', 'less:dev', 'copy:js']
	grunt.registerTask 'image', ['imagemin:comp']
