unionized = require 'unionized'
Promise = require('unionized/node_modules/bluebird')
Promise.setScheduler setImmediate # fix for sinon.useFakeTimers

module.exports = Factories = {}

Factories.word = unionized.mongooseFactory require('domain/words/models/word')

