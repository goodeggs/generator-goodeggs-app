fibrous = require 'fibrous'

Word = require 'domain/words/models/word'

module.exports = wordService =

  name: 'word_service'

  read: fibrous (req, resource, params, config) ->
    Word.find().lean().sync.exec()

module.exports = wordService

