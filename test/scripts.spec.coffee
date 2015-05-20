require './spec_helper'

describe 'generated scripts', ->

  before (done) ->
    description = "Makes delicious whipped cream in an instant!"
    @runGenerator {description}, done

  it 'npm install', (done) ->
    @timeout(10 * 60 * 1000)
    @npm 'install', done

  it 'npm test', (done) ->
    @timeout 60000
    @npm 'test', done

