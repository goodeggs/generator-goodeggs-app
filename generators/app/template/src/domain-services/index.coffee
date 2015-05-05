path = require 'path'
glob = require 'glob'

module.exports = domainServices =
  registerAll: (fetchr) ->
    for file in glob.sync(path.join(__dirname, '*/index.{coffee,js}'))
      fetchr.registerService require(file)

