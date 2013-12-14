module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    coffee:
      compile:
        files:
          'chrome-app/lib/pomodoro.js': ['src/*.coffee']
    uglify:
      build:
        src: 'chrome-app/lib/pomodoro.js',
        dest: 'chrome-app/lib/pomodoro.min.js'


  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-coffee');

  grunt.registerTask "default", ["coffee","uglify"]