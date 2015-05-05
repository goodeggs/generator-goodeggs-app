fibrous = require 'fibrous'
Word = require 'domain-models/word'

module.exports = wordService =

  name: 'word'

  read: fibrous (req, resource, params, config) ->
    switch resource
      when 'word.findAll'
        Word.find().lean().sync.exec()
      else
        throw new Error("resource #{resource} not found")

  # other methods: create, update, delete

