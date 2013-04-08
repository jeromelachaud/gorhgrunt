
module.exports = (grunt) ->

	# Initialize the configuration.
	@initConfig
		pkg: grunt.file.readJSON('package.json')
		# paths
		conf:
			path:
				jsDir:'sources/scripts/'
				coffeeDir: 'sources/coffee/'
				devDir: 'sources/#{scripts}/dev'
				prodDir: 'sources/#{scripts}/prod'
				libsDir: 'sources/scripts/libs/'
				bowLibsDir: 'sources/scripts/libs/components/'
				sassDir: 'sources/sass/'
				cssDir: 'sources/stylesheets/'
				imgSrcDir: 'sources/medias/imgSrc/'
				imgDir: 'sources/medias/img/'
				srcDir: 'sources/'
				testDir: 'test/'

			env: 'dev'
			banner: '/*! <%= pkg.name %> - V: <%= pkg.version %> <%= conf.env %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'

		#Compass task
		compass:
			options:
				cssDir: '<%= conf.path.cssDir %>'
				sassDir: '<%= conf.path.sassDir %>'
				imagesDir: '<%= conf.path.imgDir %>'
				# specify: ['<%= conf.path.sassDir %>_baseStyle.scss', 'public/sass/jquery-ui-1.10.2.custom.scss']
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

			glob_to_multiple:
				expand: true,
				cwd: '<%= conf.path.coffeeDir %>',
				src: ['*.coffee'],
				dest: '<%= conf.path.jsDir %>',
				ext: '.js'


			dev:
				sourceMap: true

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

		#copy task
		copy: {
			main: {
				files: [{
					expand: true,
					dot: true,
					cwd: '<%= conf.path.srcDir %>',
					dest: '<%= conf.path.testDir %>',
					src: [
						'**'
					]
				}]
			}
		},

		imagemin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= conf.path.imgSrcDir %>/images',
                    src: '{,*/}*.{png,jpg,jpeg}',
                    dest: '<%= conf.path.imgDir %>/images'
                }]
            }


            # grunt.log.writeln('<%= conf.path.imgSrcDir %>');
        },
		# imagemin:									# Task
		# 	files: 
		# 		expand: true,
		# 		cwd: '<%= conf.path.imgSrcDir %>',
		# 		src: ['*.{png,jpg,jpeg}'],
		# 		dest: '<%= conf.path.imgDir %>',
		# 	dist:									# Target
		# 		options:							# Target options
		# 			optimizationLevel: 3
				


		# 	dev:
		# 		options:
		# 			optimizationLevel: 0
				


	# Load Grunt plugins.
	@loadNpmTasks "grunt-contrib-compass"
	@loadNpmTasks "grunt-contrib-watch"
	@loadNpmTasks "grunt-contrib-jshint"
	@loadNpmTasks "grunt-contrib-concat"
	@loadNpmTasks "grunt-contrib-uglify"
	@loadNpmTasks "grunt-contrib-cssmin"
	@loadNpmTasks "grunt-contrib-coffee"
	@loadNpmTasks "grunt-contrib-copy"
	@loadNpmTasks "grunt-contrib-usemin"
	@loadNpmTasks "grunt-contrib-imagemin"
	
	# Default task.
	@registerTask 'default', ['compass:dev', 'concat:prod']
	@registerTask 'jshintage', ['jshint']
	@registerTask 'uglifing', ['uglify']
	@registerTask 'kawa', ['coffee:glob_to_multiple']
	@registerTask 'construct', ['coffee:glob_to_multiple','compass:prod', 'cssmin', 'concat', 'uglify']
	@registerTask 'compassion', ['cssmin']
	@registerTask 'copieur', ['copy:main']
	@registerTask 'pinture', ['imagemin:dist']
	grunt.registerTask "compliment", "Treat yo' self!", ->
		defaults = ["No one cares to customize me."]

		# Notice we use the grunt object to retrieve configuration.
		compliments = this.conf.path.imgDir  or defaults
		index = Math.floor(Math.random() * compliments.length)
		grunt.log.writeln compliments