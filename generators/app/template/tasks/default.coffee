gulp = require 'gulp'

gulp.task 'default', ->
  nodemon = require 'gulp-nodemon'
  assetsDevtool = require 'goodeggs-assets-cli/devtool'

  assetsDevtool.run()
  nodemon script: 'server.js', watch: 'src/', ext: 'js coffee cjsx'

