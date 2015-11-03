broquire = require('broquire')(require)

broquire './ui/words_service'

module.exports =
  Store: require './ui/word_store'
  Actions: require './ui/actions'

