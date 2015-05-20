path = require 'path'
helpers = require('yeoman-generator').test
{spawn} = require 'child_process'
logProcess = require 'process-logger'

before ->
  @reposlug = 'cuisinart' # prefix with node to test module name different from repo name
  @repoDir = path.join(__dirname, 'generated', @reposlug)

  @runGenerator = (prompts, done) ->
    helpers.run path.join(__dirname, '../generators/app')
      .inDir @repoDir
      .withOptions
        'skip-install': true
        'quiet': true
      .withPrompts prompts
      .on 'end', done

  @npm = (cmd, options, cb) ->
    [cb, options] = [options, {}] if not cb?

    # running npm from within npm (npm test) is tricky: we need to rid the
    # env of internal npm variables before shelling out.
    filteredEnv = {}
    filteredEnv[k] = v for k, v of process.env when k[0..3] isnt 'npm_'
  
    child = spawn 'npm', [cmd], cwd: @repoDir, env: filteredEnv
    logProcess child, prefix: '[generated]'
    child.on 'close', (code) ->
      cb(code isnt 0 and new Error("npm exited with code #{code}") or null)
    process.once 'exit', ->
      child.kill() if child.connected # just in case
    child
