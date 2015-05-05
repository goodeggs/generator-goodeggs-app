Actions = require 'ui-actions'

loadAllWords = (context, payload, cb) ->
  context.dispatch Actions.LOAD_ALL_WORDS

  context.service.read 'word.findAll', {}, {}, (err, words) ->
    if err?
      context.dispatch Actions.LOAD_ALL_WORDS_FAILURE, err
    else
      context.dispatch Actions.LOAD_ALL_WORDS_SUCCESS, words
    cb()

module.exports = loadAllWords

