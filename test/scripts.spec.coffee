require './spec_helper'
{spawn} = require 'child_process'
split = require 'split'
assert = require 'assert'
logProcess = require 'process-logger'

npm = (cmd, options, done) ->
  if not done
    done = options; options = {}

  child = spawn 'npm', [cmd]
  logProcess child, prefix: '[generated]'
  child.on 'close', done
  process.once 'exit', ->
    child.kill() if child.connected # just in case
  child

describe 'generated scripts', ->

  before (done) ->
    description = "Makes delicious whipped cream in an instant!"
    @runGenerator {description}, done

  it 'npm install', (done) ->
    @timeout 120000
    npm 'install', (code) ->
      assert.equal code, 0, 'should not error'
      done()

  it 'npm test', (done) ->
    @timeout 60000
    npm 'test', (code) ->
      assert (code is 0), 'should pass'
      done()

