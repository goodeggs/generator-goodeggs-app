Actions = require 'ui-actions'
fluxibleAsyncAction = require 'app-services/fluxible-async-action'

loadAllWords = fluxibleAsyncAction Actions.LOAD_ALL_WORDS, (context, payload, cb) ->
  context.service.read 'word_service', {}, {}, cb

module.exports = loadAllWords

