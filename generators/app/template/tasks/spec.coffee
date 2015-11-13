gulp = require 'gulp'

MOCHA_DEFAULTS =
  require: './config/boot'
  ui: 'mocha-fibers'
  reporter: 'spec'

mocha = (src, opts={}, cb) ->
  [opts, cb] = [{}, opts] if !cb and typeof opts is 'function'
  _mocha = require 'gulp-spawn-mocha'
  _ = require 'lodash'
  process.env.NODE_ENV = 'test'
  cb = _.once cb
  gulp.src(src, read: false)
    .pipe(_mocha(_.extend({}, MOCHA_DEFAULTS, opts)))
    .on 'error', cb
    .on 'end', cb
  return # don't return the stream

karma = (src, cb) ->
  path = require 'path'
  urlParse = require('url').parse
  glob = require 'glob'
  gutil = require 'gulp-util'
  browserifyBundle = require 'goodeggs-assets-cli/lib/browserify_bundle'
  _karma = require('karma').server

  files = glob.sync path.resolve(src)
  return process.nextTick(cb) unless files.length
  b = browserifyBundle src: files, dest: 'tmp/karma_entrypoint.js'
  gutil.log 'Bundling tests'
  b.bundle (err) ->
    return cb(err) if err?
    gutil.log 'Done bundling tests'
    _karma.start
      logLevel: 'ERROR' #'DEBUG' # https://github.com/karma-runner/karma/blob/master/lib/constants.js
      files: [path.resolve('tmp/karma_entrypoint.js')]
      browsers: ['Chrome']
      customLaunchers:
        'Chrome':
          base: 'WebDriver'
          config: urlParse(process.SELENIUM_URL or 'http://localhost:9515')
          browserName: 'chrome'
      frameworks: ['source-map-support', 'mocha']
      reporters: ['spec']
      singleRun: true
    , (code) ->
      cb(code isnt 0 and new Error("karma exited with #{code}") or null)

  return # don't return the stream

gulp.task 'spec', (done) ->
  # shell out and run each task in a new process to prevent
  # leaky environments or test suites.
  {spawn} = require 'child_process'
  proc = spawn '/bin/sh', ['-c', 'gulp spec:shared && gulp spec:karma && gulp spec:node && gulp spec:e2e'], stdio: 'inherit'
  proc.on 'exit', (code) ->
    done(code isnt 0 and new Error("gulp exited #{code}") or null)

gulp.task 'spec:shared', (done) ->
  gutil = require 'gulp-util'
  src = gutil.env.file or 'src/**/{*.,}spec.shared.coffee'
  gutil.log "Running '#{gutil.colors.cyan('spec:shared')}' with #{gutil.colors.magenta('Karma')}"
  karma src, (err) ->
    return done(err) if err?
    gutil.log "Running '#{gutil.colors.cyan('spec:shared')}' with #{gutil.colors.magenta('Node')}"
    mocha src, done

gulp.task 'spec:karma', (done) ->
  gutil = require 'gulp-util'
  src = gutil.env.file or 'src/**/{*.,}spec.karma.coffee'
  karma src, done

gulp.task 'spec:node', (done) ->
  gutil = require 'gulp-util'
  src = gutil.env.file or 'src/**/{*.,}spec.node.coffee'
  mocha src, done

gulp.task 'spec:e2e', (done) ->
  gutil = require 'gulp-util'
  src = gutil.env.file or 'src/**/{*.,}spec.e2e.coffee'
  mocha src, timeout: 30000, done

