url = require('lib/url')
serializeParams = url.serializeParams

UrlActions = require('actions/url_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [UrlActions]
  mixins: [RefluxStateMixin]

  getInitialState: ->
    params: url.params()

  # accessors
  serializeParams: ->
    # TODO: figure out why in the world children is added to the store state
    params = _.omit(@state.params, 'children')
    serializeParams(params)

  # note: params is used internally by reflux, cannot use that as a method name
  getParam: (key) ->
    @state.params[key]

  hasHistory: ->
    @router().hasHistory()

  ##
  # Events
  ##
  onBack: ->
    @router().back()

  onSetParams: (params) ->
    p = _.extend(@state.params, params)
    @setState(params: p)
    @updateUrl()

  onNavigateTo: (to, params = {}) ->
    defaultParams = {lang: @state.params.lang}
    params = _.extend defaultParams, params
    @setState(params: params)
    @router().visit(to + @serializeParams())

  ##
  # Helpers
  ##
  router: -> router = require('lib/router')
  updateUrl: -> @router().update(@serializeParams())
