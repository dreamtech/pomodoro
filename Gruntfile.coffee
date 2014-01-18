module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    uglify:
      build:
        src: 'chrome-app/lib/pomodoro.js',
        dest: 'chrome-app/lib/pomodoro.min.js'

    watch:
      files: ['src/*.coffee','tests/*.coffee','chrome-app/**','!chrome-app/lib/**']
      tasks: ['test','compile','launch']
      options:
        livereload:
          port: 9000
        interrupt: true

    bgShell:
      _defaults:
        bg: false
        stdout: true
        stderr: true
        fail: true

      runMochaTests:
        cmd: 'echo "|- - - Running Unit tests - - -|";'+
             'mocha --compilers coffee:coffee-script --reporter spec src/main.coffee tests/*'
        done: (err, stdout)->
          console.log '|- - - Finnished running Unit tests - - -|'
          if (err)
            console.error err

      browserify:
        cmd: 'browserify -t coffeeify src/main.coffee src/*.coffee > chrome-app/lib/pomodoro.js'

      runPomodoro:
        cmd: 'run-pomodoro.sh'

  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-bg-shell'

  grunt.registerTask 'default', ['watch']
  grunt.registerTask 'compile', ['bgShell:browserify','uglify']
  grunt.registerTask 'test', ['bgShell:runMochaTests']
  grunt.registerTask 'launch', ['bgShell:runPomodoro']