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

    user:
      id: 0
      accept_terms: null
      country: null
      country_id: 0
      email: null
      errors: null
      first_name: null
      language: "en"
      last_name: null
      password: null
      token: null

    loaded: false
    errors: null
    language: Cookies.get('lang') || 'en'
    guidedSearch: guidedSearch

  onLoadUserCompleted: (user) ->
    @setState(user: user, loaded: true, errors: null, language: user.language)

  onLoadUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)

  onUpdateUserCompleted: (user) ->
    @setState(user: _.extend(@state.user, user), loaded: true, errors: null, language: user.language || @state.language)

  onUpdateUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)

  onChangeLanguage: (language) ->
    Cookies.set('lang', language)
    @setState(language: language)
    window.location.reload()

  onToggleGuidedSearch: (language) ->
    @setState(guidedSearch: !@state.guidedSearch)
    Cookies.set('guided_search', @state.guidedSearch)

  onToggleComplementaryContent: (fieldName) ->
    user = @state.user
    user[fieldName] = !user[fieldName]
    @setState(user: user)
    UserActions.updateUser(user)

  onCreateUserCompleted: (user) ->
    @setState(user: user, loaded: true, language: user.language)
    Cookies.set('token', user.token)

  onCreateUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)

  onLoginUserCompleted: (user) ->
    @setState(user: user, loaded: true, language: user.language)
    Cookies.set('token', user.token)

  onLoginUserFailed: (xhr) ->
    errors = ['unknown_error']
    if xhr.status == 403
      errors = ['invalid_login']
    @setState(errors: errors, loaded: true)
