Fluxible = require 'fluxible'

WelcomePage = require './component'
Words = require 'domain/words'
fetchr = require 'app-services/fetchr'

app = new Fluxible component: WelcomePage
app.registerStore(Words.Store)
app.plug(fetchr)

module.exports = app

