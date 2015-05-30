mongoose = require 'mongoose'
fibrous = require 'fibrous'

module.exports =

  reset: fibrous ->
    futures = []
    for connection in mongoose.connections
      for name, collection of connection.collections
        futures.push collection.future.remove()
    fibrous.wait futures

