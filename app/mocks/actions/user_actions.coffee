API = require('lib/api')
StoreMock = require('mocks/support/store_mock')

UserActions = Reflux.createActions
  changeLanguage: {}
  toggleGuidedSearch: {}
  toggleComplementaryContent: {}
  createUser: {asyncResult: true}
  loginUser: {asyncResult: true}
  logoutUser: {asyncResult: true}
  updateUser: {asyncResult: true}
  loadUser: {asyncResult: true}
  forgotPassword: {asyncResult: true}
  resetPassword: {asyncResult: true}
  loadRegion: {asyncResult: true}
  unsubscribe: {asyncResult: true}
  saveSearch: {asyncResult: true}
  removeSearches: {asyncResult: true}
  saveArticles: {asyncResult: true}

UserActions.createUser.listen (user) ->
  user.errors = {}
  if _.isEmpty(user.email)
    user.errors.email = "cant_be_blank"
  if _.isEmpty(user.password)
    user.errors.password = "can't be blank!"
  if _.isEmpty(user.confirm_password)
    user.errors.confirm_password = "can't be blank!"
  if user.accept_terms != "on" && user.accept_terms != true
    user.errors.accept_terms = "must_accept_terms"

  if _.isEmpty(user.errors)
    API.read('user').done (u) =>
      user = _.extend(u, user)
      StoreMock.send(user, (=> @completed(user)), 'POST /users')
  else
    StoreMock.sendError(400, user, (=> @failed({}, 'bad data', user)), 'POST /users')

UserActions.loadUser.listen ->
  API.read('user').done(@completed).fail(@failed)

UserActions.updateUser.listen (user) ->
  @completed(user)

UserActions.loginUser.listen (user) ->
  user.errors = {}
  if _.isEmpty(user.email)
    user.errors.email = "can't be blank!"
  if _.isEmpty(user.password)
    user.errors.password = "can't be blank!"

  if _.isEmpty(user.errors)
    API.read('user').done (u) =>
      user = _.extend(u, user)
      StoreMock.send user, (=> @completed(user)), 'POST /login/login'
  else
    StoreMock.sendError 400, user, (=> @failed({}, "bad input", user)), 'POST /users/login'

UserActions.logoutUser.listen (user) ->
  StoreMock.send user, (=> @completed(user)), 'GET /user/logout'

UserActions.forgotPassword.listen (data) ->
  StoreMock.send data, (=> @completed(data)), 'POST /user/forgotPassword'

UserActions.resetPassword.listen (data) ->
  API.read('user').done (user) =>
    StoreMock.send data, (=> @completed(user)), 'POST /user/reset_password'

UserActions.loadRegion.listen ->
  API.read('geo').done(@completed).fail(@failed)

UserActions.unsubscribe.listen (x) ->
  data = {x: x}
  StoreMock.send data, (=> @completed(data)), 'POST /user/unsubscribe'

UserActions.saveSearch.listen (search) ->
  Promise.resolve(search).then(@completed)

UserActions.removeSearches.listen (searches) ->
  Promise.resolve({status: 'OK'})

UserActions.saveArticles.listen (articles) ->
  ids = _.pluck(articles, 'id')
  console.log('saving articles', ids)
  Promise.resolve({status: 'OK'})

module.exports = UserActions
