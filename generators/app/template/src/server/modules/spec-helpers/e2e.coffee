require './node'

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

