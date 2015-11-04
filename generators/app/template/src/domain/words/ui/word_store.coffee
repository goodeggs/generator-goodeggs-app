{BaseStore} = require 'fluxible/addons'
_ = require 'lodash'

Actions = require './actions'

class WordStore extends BaseStore

  @storeName: 'WordStore'

  @handlers:
    "#{Actions.LOAD_ALL_WORDS_SUCCESS}": 'onLoadAllWordsSuccess'

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

