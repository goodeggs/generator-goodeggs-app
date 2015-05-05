Fluxible = require 'fluxible'

WelcomePage = require './component'
WordStore = require 'ui-stores/word_store'
fetchr = require 'app-services/fetchr'

app = new Fluxible component: WelcomePage
app.registerStore(WordStore)
app.plug(fetchr)

module.exports = app

