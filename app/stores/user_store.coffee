API = require('lib/api')
UserActions = require('actions/user_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [UserActions]
  mixins: [RefluxStateMixin]

  getInitialState: ->
    if Cookies.get('guided_search')
      guidedSearch = Cookies.get('guided_search') == 'true'
    else
      guidedSearch = true

    user: null
    loaded: false
    errors: null
    language: Cookies.get('lang') || 'en'
    guidedSearch: guidedSearch

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
    @setState(language: language)
    window.location.reload()

  onToggleGuidedSearch: (language) ->
    @setState(guidedSearch: !@state.guidedSearch)
    Cookies.set('guided_search', @state.guidedSearch)
    @trigger(@state)

  onCreateUserCompleted: (data) ->
    user = data.user
    @setState(user: user, loaded: true, language: user.language)
    @trigger(@state)

  onCreateUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)
    @trigger(@state)

  onLoginUserCompleted: (data) ->
    user = data.user
    @setState(user: user, loaded: true, language: user.language)
    @trigger(@state)

  onLoginUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)
    @trigger(@state)
