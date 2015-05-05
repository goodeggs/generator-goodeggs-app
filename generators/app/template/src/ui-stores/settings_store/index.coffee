{BaseStore} = require 'fluxible/addons'
Actions = require 'ui-actions'
_ = require 'lodash'

class SettingsStore extends BaseStore
  @storeName: 'SettingsStore'

  @handlers:
    "#{Actions.LOAD_SETTINGS_SUCCESS}": 'onLoadSettingsSuccess'

  constructor: (dispatcher) ->
    super
    @settings = {}

  onLoadSettingsSuccess: (settings) ->
    _.extend(@settings, settings)
    @emitChange()

  dehydrate: ->
    {@settings}

  rehydrate: (state) ->
    @settings = state.settings

module.exports = SettingsStore

