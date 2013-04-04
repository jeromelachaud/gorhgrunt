
module.exports = (grunt) ->

	# Initialize the configuration.
	@initConfig
		pkg: grunt.file.readJSON('package.json')

		#Compass task
		compass:
			options:
					cssDir: 'public/styles'
					sassDir: 'public/sass/'
					imagesDir: 'public/images'
					specify: ['public/sass/rhtools.scss', 'public/sass/jquery-ui-1.10.2.custom.scss']
					javascriptsDir: 'public/scripts'
					force: true

			dev:
				options:
					debugInfo :true

			prod:
				options:
					debugInfo :false
		# Concat Task
		concat:
			dev:
				src: ['public/scripts/vendor/jquery.uniform.js',
					'public/scripts/vendor/waypoints.js',
					'public/scripts/vendor/waypoints-sticky.min.js',
					'public/scripts/vendor/fx.js',
					'public/scripts/vendor/jquery.chosen.js',
					'public/scripts/vendor/jquery.nouislider.js']
				dest: 'public/scripts/build/plugins.js'

			prod:
				src: ['public/scripts/build/plugins.js',
					'public/scripts/ui.js',
					'public/scripts/hrAppSearch.js',
					'public/scripts/widget.js',
					'public/scripts/main.js'],
				dest: 'public/scripts/build/scripts.concat.js'

		# JSHint task
		jshint:
			files: ['<%= watch.jsFiles.files %>']

			options:
				browser: true
				boss: true
				curly: false
				eqeqeq: false
				eqnull: true
				camelcase : false
				evil : false
				shadow: false
				globals:
					jQuery: true

		# uglify task
		uglify:
			prod:
				options:
					sourceMap: 'public/scripts/build/scripts.min-map.js'

				files:
					'public/scripts/build/scripts.min.js': ['<%= concat.prod.dest %>']

		# css min Task
		cssmin:
			compress:
				options:
					banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
					report: 'gzip'

				files:
					'public/styles/rhtools.min.css': ['public/styles/rhtools.css']

		# Coffee task
		coffee:
			options:
				bare: true

			compile:
				files:
					'public/scripts/main.js': 'public/coffee/main.coffee'
					'public/scripts/uiTest.js': 'public/coffee/ui.coffee'

		#watch task
		watch:
			scss:
				files: ['<%= compass.options.sassDir %>/*.scss'],
				tasks: ['compass:dev']

			jsFiles:
				files: ['public/scripts/main.js','public/scripts/ui.js'] #,'public/scripts/hrAppSearch.js'
				tasks: ['jshintage']

			coffee:
				files: 'public/coffee/*.coffee'
				tasks: ['kawa']

	# Load Grunt plugins.
	@loadNpmTasks "grunt-contrib-compass"
	@loadNpmTasks "grunt-contrib-watch"
	@loadNpmTasks "grunt-contrib-jshint"
	@loadNpmTasks "grunt-contrib-concat"
	@loadNpmTasks "grunt-contrib-uglify"
	@loadNpmTasks "grunt-contrib-cssmin"
	@loadNpmTasks "grunt-contrib-coffee"

	# Default task.
	@registerTask "default", ["jshint"]
	@registerTask 'default', ['compass:dev', 'concat:dev']
	@registerTask 'jshintage', ['jshint']
	@registerTask 'uglifing', ['uglify']
	@registerTask 'kawa', ['coffee:compile']
	@registerTask 'construct', ['coffee:compile','compass:prod', 'cssmin', 'concat', 'uglify']
	@registerTask 'compassion', ['cssmin']
