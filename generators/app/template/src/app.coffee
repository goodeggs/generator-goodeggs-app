fibrous = require 'fibrous'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'
mongooseConnectionManager = require('mongoose-connection-manager')(mongoose)
logger = require 'goodeggs-logger'
stats = require 'goodeggs-stats'
assets = require 'goodeggs-assets'
express = require 'express'
helmet = require 'helmet'
compression = require 'compression'

settings = require './server/modules/settings'
fetchr = require 'app-services/fetchr'

server = null
app = express()

app.use logger.middleware.request
app.use helmet.hidePoweredBy()
app.use compression()
app.use assets.middleware()
app.use helmet.noCache()
app.use helmet.frameguard()
app.use bodyParser.urlencoded(extended: true)
app.use bodyParser.json()
app.use fetchr.getXhrPath(), fetchr.getMiddleware()
app.use fibrous.middleware

# your app handlers go here
app.use require('./ui-pages/welcome_page/controller')

app.use (req, res, next) ->
  res.status(404).send 'File not found' unless res.headersSent

app.use logger.middleware.error
app.use (err, req, res, next) ->
  res.status(500).send err.stack or err unless res.headersSent

app.connect = fibrous ->
  stats.configure settings.stats.token? and settings.stats or {simulate: true}
  logger.configure name: settings.name, level: settings.log.level
  logger.console.redirect() unless settings.env in ['development', 'test']
  stats.sync.start()
  mongooseConnectionManager.setLogger(logger)
  mongooseConnectionManager.create(name, dbSettings) for name, dbSettings of settings.mongo
  mongooseConnectionManager.sync.connect()
  # connect to other services here

app.disconnect = fibrous ->
  # disconnect from other services here
  mongooseConnectionManager.sync.disconnect()
  stats.sync.stop()

app.start = (cb) ->
  app.connect (err) ->
    return cb(err) if err?
    server = app.listen settings.port, settings.ip
    server.once 'listening', ->
      logger.info "#{settings.name} is listening at #{server.address().address}:#{server.address().port} in #{settings.env} mode"
      cb()

app.stop = (cb) ->
  server?.close()
  app.disconnect cb

module.exports = app

