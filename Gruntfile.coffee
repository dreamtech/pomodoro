module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    coffee:
      compile:
        files:
          'chrome-app/lib/pomodoro.js': ['src/*.coffee']
    uglify:
      build:
        src: 'chrome-app/lib/pomodoro.js',
        dest: 'chrome-app/lib/pomodoro.min.js'
    watch:
      files: 'src/*.coffee'
      tasks: ['compile']
      options:
        livereload:
          port: 9000
        interrupt: true


  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['watch']
  grunt.registerTask 'compile', ['coffee','uglify']