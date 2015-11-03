{BaseStore} = require 'fluxible/addons'
Words = require 'domain/words'
_ = require 'lodash'

class WordStore extends BaseStore

  @storeName: 'WordStore'

  @handlers:
    "#{Words.Actions.LOAD_ALL_WORDS_SUCCESS}": 'onLoadAllWordsSuccess'

  constructor: (dispatcher) ->
    super
    @words = {}

  onLoadAllWordsSuccess: (words) ->
    @words = _(words).indexBy('_id').merge(@words).value()
    @emitChange()

  getAll: ->
    _.values(@words)

  dehydrate: ->
    {@words}

  rehydrate: (state) ->
    @words = state.words

module.exports = WordStore

