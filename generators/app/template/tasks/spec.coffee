gulp = require 'gulp'

MOCHA_DEFAULTS =
  require: './config/boot'
  ui: 'mocha-fibers'
  reporter: 'spec'

mocha = (src, opts={}) ->
  _mocha = require 'gulp-spawn-mocha'
  _ = require 'lodash'
  process.env.NODE_ENV = 'test'
  gulp.src(src, read: false)
    .pipe(_mocha(_.extend({}, MOCHA_DEFAULTS, opts)))

gulp.task 'spec', (done) ->
  gutil = require 'gulp-util'

  if gutil.env.file?
    mocha(gutil.env.file)
  else
    runSequence = require 'run-sequence'
    runSequence 'spec:e2e', done
    #runSequence 'spec:node', 'spec:browser', 'spec:e2e', done

#gulp.task 'spec:node', ->
#  mocha('src/**/spec.node.coffee')

#gulp.task 'spec:browser', ->
#  mocha('src/**/spec.browser.coffee')

gulp.task 'spec:e2e', ->
  mocha('src/**/spec.e2e.coffee', timeout: 30000)

