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
      tasks: ['compile','test']
      options:
        livereload:
          port: 9000
        interrupt: true
    bgShell:
      _defaults:
        bg: true
        stdout: true
        stderr: true
        fail: true

      runMochaTests:
        cmd: 'echo "|- - - Running Unit tests - - -|";'+
             'mocha --compilers coffee:coffee-script --reporter spec tests/*'

        bg: false
        fail: true
        done: (err, stdout)->
          console.log '|- - - Finnished running Unit tests - - -|'
          if (err)
            console.error err

  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-bg-shell'

  grunt.registerTask 'default', ['watch']
  grunt.registerTask 'compile', ['coffee','uglify']
  grunt.registerTask 'test', ['bgShell:runMochaTests']