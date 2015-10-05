API = require('lib/api')
UserActions = require('actions/user_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

params = require('lib/url').params()

module.exports = Reflux.createStore
  listenables: [UserActions]
  mixins: [RefluxStateMixin]

  getInitialState: ->
    if Cookies.get('guided_search')
      guidedSearch = Cookies.get('guided_search') == 'true'
    else
      guidedSearch = true

    # TODO: instead of having language outside of the guest object and then updating it,
    # have an guest user object. Can even query the API for guest users.
    user: null
    loaded: false
    errors: null
    language: params.lang || 'en'
    guidedSearch: guidedSearch
    region: params.region || 'worldwide'

  onLoadUserCompleted: (user) ->
    @setState(user: user, loaded: true, errors: null, language: params.lang || user.language)

  onLoadUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)

  onUpdateUserCompleted: (user) ->
    user = _.extend({}, @state.user, user)
    @setState(user: user, loaded: true, errors: null, language: user.language)

  onUpdateUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)

  onChangeLanguage: (language) ->
    if @state.loaded
      UserActions.updateUser({language: language}).then =>
        window.location.reload()
    else
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

  onLogoutUserCompleted: ->
    @setState(user: null, loaded: false, errors: null)
    Cookies.remove('token')

  onLogoutUserFailed: ->
    @setState(errors: ['faild_logout'])

  onForgotPasswordCompleted: ->
    @setState(loaded: false)

  onForgotPasswordFailed: () ->
    @setState(errors: ['wrong_email'])

  onResetPasswordCompleted: (user) ->
    @setState(user: user, loaded: true, errors: null)

  onResetPasswordFailed: ->
    @setState(errors: ['failed_password_reset'])

  onLoadRegionCompleted: (geo) ->
    if geo.region_code == 'ON'
      region = 'ontario'
    else if geo.country_code == 'CA'
      region = 'canada'
    else
      region = 'worldwide'

    @setState(region: params.region || region)
