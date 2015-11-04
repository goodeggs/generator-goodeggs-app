fluxibleAsyncAction = require 'app-services/fluxible-async-action'

Actions =
  LOAD_ALL_WORDS: 'words.loadAllWords'
  LOAD_ALL_WORDS_SUCCESS: 'words.loadAllWords.success'
  LOAD_ALL_WORDS_FAILURE: 'words.loadAllWords.failure'

Actions.loadAllWords = fluxibleAsyncAction Actions.LOAD_ALL_WORDS, (context, payload, cb) ->
  context.service.read 'words', {}, {}, cb

module.exports = Actions

