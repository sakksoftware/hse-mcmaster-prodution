API = require('lib/api')
UserActions = require('actions/user_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [UserActions]
  mixins: [RefluxStateMixin]

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

  onCreateUser: (user, success, error) ->
    API.create 'users', { user: user },
      success: success
      error: error

  onLoginUser: (user, success, error) ->
    API.create 'users', { user: user },
      success: success
      error: error
