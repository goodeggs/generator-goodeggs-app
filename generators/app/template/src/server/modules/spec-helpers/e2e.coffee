unless describe?
  {specExec} = require 'goodeggs-spec-helpers/runner'
  specExec (specModule) -> ['gulp', 'spec:e2e', "--file=#{specModule.filename}"]

require './index'
require 'goodeggs-spec-helpers/node_helper'

global.Factories = require './factories'

database = require './database'

webdriverBuilder = require 'wd'

settings = require '../settings'
app = require '../../../app'

before ->
  @timeout 0
  app.sync.start()
  @browser = webdriverBuilder.promiseChainRemote(process.SELENIUM_URL or 'http://localhost:9515')
  @browser.sync.init browserName: 'chrome'
  @browser.configureHttp baseUrl: settings.server.url

after ->
  @timeout 0
  @browser.sync.quit()
  app.sync.stop()

global.flow = (message, body) ->
  describe message, ->
    before ->
      @sinon = sinon.sandbox.create()
      database.sync.reset()

    after ->
      @sinon.restore()

    body()

