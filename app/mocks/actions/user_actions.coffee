API = require('lib/api')
StoreMock = require('mocks/support/store_mock')

UserActions = Reflux.createActions
  changeLanguage: {}
  toggleGuidedSearch: {}
  toggleComplementaryContent: {}
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
    API.read('/user').done (u) =>
      user = _.extend(u, user)
      StoreMock.send(user, (=> @completed(user)), 'POST /users')
  else
    StoreMock.sendError(400, user, null, (=> @failed({}, 'bad data', user)), 'POST /users')

UserActions.loadUser.listen ->
  API.read('/user').done(@completed).fail(@failed)

UserActions.updateUser.listen (user) ->
  @completed(user)

UserActions.loginUser.listen (user) ->
  user.errors = {}
  if _.isEmpty(user.email)
    user.errors.email = "can't be blank!"
  if _.isEmpty(user.password)
    user.errors.password = "can't be blank!"

  if _.isEmpty(user.errors)
    API.read('/user').done (u) =>
      user = _.extend(u, user)
      StoreMock.send user, (=> @completed(user)), 'POST /login'
  else
    StoreMock.sendError 400, user, null, (=> @failed({}, "bad input", user)), 'POST /users'

module.exports = UserActions
