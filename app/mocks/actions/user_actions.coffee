API = require('lib/api')
StoreMock = require('mocks/support/store_mock')

UserActions = Reflux.createActions
  changeLanguage: {}
  createUser: {asyncResult: true}
  loginUser: {asyncResult: true}
  updateUser: {asyncResult: true}
  loadUser: {asyncResult: true}

UserActions.createUser.listen (user) ->
  user.errors = {}
  if _.isEmpty(user.email)
    user.errors.email = "cant_be_blank"
  if _.isEmpty(user.password)
    user.errors.password = "can't be blank!"
  if _.isEmpty(user.confirm_password)
    user.errors.confirm_password = "can't be blank!"
  if user.accept_terms != "on"
    user.errors.accept_terms = "must_accept_terms"

  if _.isEmpty(user.errors)
    StoreMock.send(user: user, (=> @completed.trigger(user: user)), 'POST /users')
  else
    StoreMock.sendError(400, user: user, null, (=> @failed.trigger({}, 'bad data', user: user)), 'POST /users')

UserActions.loadUser.listen ->
  API.read('/user').done(@completed).fail(@failed)

UserActions.updateUser.listen (user) ->
  @completed.trigger(user)

UserActions.loginUser.listen (user) ->
  user.errors = {}
  if _.isEmpty(user.email)
    user.errors.email = "can't be blank!"
  if _.isEmpty(user.password)
    user.errors.password = "can't be blank!"

  if _.isEmpty(user.errors)
    StoreMock.send user: user, (=> @completed.trigger(user: user)), 'POST /login')
  else
    StoreMock.sendError 400, user: user, null, (=> @failed.trigger({}, "bad input", user: user)), 'POST /users'

module.exports = UserActions
