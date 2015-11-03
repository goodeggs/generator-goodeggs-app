fibrous = require 'fibrous'
fetchr = require 'app-services/fetchr'

Word = require './models/word'

module.exports = wordService =

  name: 'words'

  read: fibrous (req, resource, params, config) ->
    Word.find().lean().sync.exec()

fetchr.registerService wordService

module.exports = wordService

