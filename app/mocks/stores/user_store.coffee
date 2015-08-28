API = require('lib/api')
UserActions = require('actions/user_actions')
StoreMock = require('mocks/support/store_mock')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [UserActions]
  mixins: [RefluxStateMixin, StoreMock]

  getInitialState: ->
    user: null
    loaded: false
    errors: null
    language: Cookies.get('lang') || 'en'

  onLoadUserCompleted: (user) ->
    @setState(user: user, loaded: true, errors: null, language: user.language)
    @trigger(@state)

  onLoadUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)
    @trigger(@state)

  onUpdateUserCompleted: (user) ->
    @setState(user: _.extend(@state.user, user), loaded: true, errors: null, language: user.language || @state.language)
    @trigger(@state)

  onUpdateUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)
    @trigger(@state)

  onChangeLanguage: (language) ->
    Cookies.set('lang', language)
    window.location.reload()

  onCreateUserCompleted: (data) ->
    @setState(user: data.user, loaded: true, errors: null)
    @trigger(@state)

  onCreateUserFailed: (xhr, statusCode, responseText) ->
    @setState(loaded: true, errors: responseText)
    @trigger(@state)

  onLoginUserCompleted: (data) ->
    @setState(user: data.user, loaded: true, errors: null)
    @trigger(@state)

  onLoginUserFailed: (xhr, statusCode, responseText) ->
    try
      data = JSON.parse(responseText)
    catch
      data = null

    @setState(loaded: true, errors: statusCode)
