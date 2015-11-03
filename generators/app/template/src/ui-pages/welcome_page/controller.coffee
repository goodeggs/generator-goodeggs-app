express = require 'express'

layout = require '../../server/modules/layout'
{loadAllWords} = require('domain/words').Actions

class Page
  @getInstance: (requirePath) ->
    app = require(requirePath)
    context = app.createContext()
    new Page {app, context, requirePath}

  constructor: ({@app, @context, @requirePath}) ->
    # noop


server = express()

server.get '/', (req, res) ->
  page = Page.getInstance 'ui-pages/welcome_page'
  page.context.sync.executeAction loadAllWords, {}
  res.send layout(res.locals, {page})

module.exports = server

