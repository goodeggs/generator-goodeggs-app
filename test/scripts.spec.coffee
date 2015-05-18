require './spec_helper'
{spawn} = require 'child_process'
logProcess = require 'process-logger'

npm = (cmd, options, cb) ->
  [cb, options] = [options, {}] if not cb?

  child = spawn 'npm', [cmd]
  logProcess child, prefix: '[generated]'
  child.on 'close', (code) ->
    cb(code isnt 0 and new Error("npm exited with code #{code}") or null)
  process.once 'exit', ->
    child.kill() if child.connected # just in case
  child

describe 'generated scripts', ->

  before (done) ->
    description = "Makes delicious whipped cream in an instant!"
    @runGenerator {description}, done

  it 'npm install', (done) ->
    @timeout(10 * 60 * 1000)
    npm 'install', done

  it 'npm test', (done) ->
    @timeout 60000
    npm 'test', done

