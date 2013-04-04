
module.exports = (grunt) ->

	# Initialize the configuration.
	@initConfig
		pkg: grunt.file.readJSON('package.json')
		# paths
		conf:
			path:
				jsDir:'scripts/'
				coffeeDir: 'coffee/'
				devDir: '#{scripts}/dev'
				prodDir: '#{scripts}/prod'
				libsDir: 'scripts/libs/'
				bowLibsDir: 'scripts/libs/components/'
				sassDir: 'scss/'
				cssDir: 'stylesheets/'
				imgDir: 'images/'

			env: 'dev'
			banner: '/*! <%= pkg.name %> - V: <%= pkg.version %> <%= conf.env %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'

		#Compass task
		compass:
			options:
				cssDir: '<%= conf.path.cssDir %>'
				sassDir: '<%= conf.path.sassDir %>'
				imagesDir: '<%= conf.path.imgDir %>'
				#specify: ['public/sass/rhtools.scss', 'public/sass/jquery-ui-1.10.2.custom.scss']
				javascriptsDir: '<%= conf.path.jsDir %>'
				force: true
			files:['<%= conf.path.sassDir %>']

			dev:
				options:
					debugInfo :true

			prod:
				options:
					debugInfo :false

		# Concat Task
		concat:
			options:
				banner: '<%= conf.banner %>'

			prod:
				src:['<%= conf.path.libsDir %>/**/*.js'
				]
				dest: '<%= conf.path.libsDir %>/plugins.js'


		# JSHint task
		jshint:
			files: ['<%= watch.jsFiles.files %>']

			options:
				# browser: true
				# boss: true
				# curly: false
				# eqeqeq: false
				# eqnull: true
				# camelcase : false
				# evil : false
				# shadow: false
				globals:
					jQuery: true

		# uglify task
		uglify:
			prod:
				options:
					sourceMap: '<%= conf.path.libsDir %>scripts.min-map.js'

				files:
					'<%= conf.path.prodDir %>scripts.min.js': ['<%= concat.prod.dest %>']

		# css min Task
		cssmin:
			compress:
				options:
					banner: '<%= conf.banner %>'
					report: 'gzip'

				files:
					'<%= conf.path.cssDir %>screen.min.css': ['<%= conf.path.cssDir %>screen.css']

		# Coffee task
		coffee:
			options:
				bare: true

			compile:
				files:
					'<%= conf.path.jsDir %>main.js': '<%= conf.path.coffeeDir %>main.coffee'


		#watch task
		watch:
			scss:
				files: ['<%= compass.options.sassDir %>*.scss'],
				tasks: ['compass:dev']

			jsFiles:
				files: ['<%= conf.path.jsDir %>main.js'] #,'public/scripts/hrAppSearch.js'
				tasks: ['jshintage']

			coffee:
				files: '<%= conf.path.coffeeDir %>*.coffee'
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
	@registerTask 'default', ['compass:dev', 'concat:prod']
	@registerTask 'jshintage', ['jshint']
	@registerTask 'uglifing', ['uglify']
	@registerTask 'kawa', ['coffee:compile']
	@registerTask 'construct', ['coffee:compile','compass:prod', 'cssmin', 'concat', 'uglify']
	@registerTask 'compassion', ['cssmin']
