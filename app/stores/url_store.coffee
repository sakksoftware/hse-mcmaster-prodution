serializeParams = require('lib/url').serializeParams
UrlActions = require('actions/url_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [UrlActions]
  mixins: [RefluxStateMixin]

  getInitialState: ->
    urlParams: {}

  updateUrl: ->
    Router = require('lib/router')
    # TODO: figure out why in the world children is added to the store state
    params = _.omit(@state.urlParams, 'children')
    Router.update(serializeParams(params))

  onSetParams: (params) ->
    p = _.extend(@state.urlParams, params)
    @setState(urlParams: p)
    @updateUrl()
