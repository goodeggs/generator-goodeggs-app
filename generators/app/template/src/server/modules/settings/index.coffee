convict = require 'convict'
logger = require 'goodeggs-logger'

settings = convict
  env:
    doc: 'The applicaton environment.'
    format: ['production', 'development', 'test']
    default: 'development'
    env: 'NODE_ENV'

  name:
    doc: 'The application name.'
    format: '*'
    default: '<%= basename %>'
    env: 'APP_NAME'

  ip:
    doc: 'The IP address to bind.'
    format: 'ipaddress'
    default: '127.0.0.1'
    env: 'IP_ADDRESS'

  port:
    doc: 'The port to bind.'
    format: 'port'
    default: null
    env: 'PORT'

  stats:
    email:
      doc: 'The Librato email address.'
      format: '*'
      default: null
      env: 'STATS_EMAIL'
    token:
      doc: 'The Librato token.'
      format: '*'
      default: null
      env: 'STATS_TOKEN'

  log:
    level:
      doc: 'The log level for the default STDOUT stream.'
      format: ['trace', 'debug', 'info', 'warn', 'error', 'fatal']
      default: 'info'
      env: 'LOG_LEVEL'

  server:
    url:
      doc: 'The canonical base URL of this app'
      format: 'url'
      default: null
      env: 'SERVER_URL'

  mongo:
    <%= basename %>:
      url:
        format: '*'
        default: null
        env: 'MONGO_URL'

unless settings.get('port')?
  settings.set 'port', settings.get('env') is 'test' and 3001 or 3000

unless settings.get('server.url')?
  settings.set 'server.url', "http://localhost:#{settings.get('port')}"

if settings.get('env') is 'test'
  settings.set 'log.level', 'warn'

settings.set 'mongo.<%= basename %>.url', "mongodb://localhost/<%= basename %>_#{settings.get('env')}" unless settings.get('mongo.<%= basename %>.url')?
settings.set 'mongo.<%= basename %>.useDefault', true
settings.set 'mongo.<%= basename %>.options',
  server:
    socketOptions: {keepAlive: 1, connectTimeoutMS: 30000}
  replset:
    w: 'majority'
    socketOptions: {keepAlive: 1, connectTimeoutMS: 30000}

settings.validate()

module.exports = settings.root()

