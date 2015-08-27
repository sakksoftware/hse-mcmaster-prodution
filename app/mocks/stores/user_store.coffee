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

  onLoadUserCompleted: (user) ->
    @setState(user: user, loaded: true, errors: null)
    @trigger(@state)

  onLoadUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)
    @trigger(@state)

  onUpdateUserCompleted: (user) ->
    @setState(user: _.extend(@state.user, user), loaded: true, errors: null)
    @trigger(@state)

  onUpdateUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)
    @trigger(@state)

  onCreateUser: (user, success, error) ->
    user.errors = {}
    if _.isEmpty(user.email)
      user.errors.email = "can't be blank!"
    if _.isEmpty(user.password)
      user.errors.password = "can't be blank!"
    if _.isEmpty(user.confirm_password)
      user.errors.confirm_password = "can't be blank!"
    if user.accept_terms != "on"
      user.errors.accept_terms = "You must accept the terms and conditions!"

    if _.isEmpty(user.errors)
      @send(user, success, 'POST /users')
    else
      @sendError(400, user: user, error, 'POST /users')

  onLoginUser: (user, success, error) ->
    user.errors = {}
    if _.isEmpty(user.email)
      user.errors.email = "can't be blank!"
    if _.isEmpty(user.password)
      user.errors.password = "can't be blank!"

    if _.isEmpty(user.errors)
      @send(user, success, 'POST /users')
    else
      @sendError(400, user: user, error, 'POST /users')
