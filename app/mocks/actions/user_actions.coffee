API = require('lib/api')
StoreMock = require('mocks/support/store_mock')

# private Data
articlesData = [{
  "id": "all_filled_all_visible",
  "traversal": "tencharacters",
  "title": "All <B>fields</B> Filled & Visible",
  "created_at": "2014-09-20 11:33:00Z",
  "updated_at": "2014-09-20 11:33:00Z",
  "quality": "7/11",
  "description": "Some <B>Crazy</B> long description goes here.....",
  "category": "<B>International</B> Organizations Document",
  "country_groupings": "<B>USA</B> (26); UK (2); Australia (1); Turkey (1)"
}]
searchesData = []

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
  loadSearches: {asyncResult: true}
  saveSearch: {asyncResult: true}
  removeSearches: {asyncResult: true}
  saveArticles: {asyncResult: true}
  loadArticles: {asyncResult: true}
  removeArticles: {asyncResult: true}
  emailArticles: {asyncResult: true}

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

UserActions.loadSearches.listen ->
  Promise.resolve(searchesData).then(@completed)

UserActions.saveSearch.listen (search) ->
  searchesData.push(search)
  Promise.resolve(search).then(@completed)

UserActions.removeSearches.listen (searches) ->
  toDelete = _(searchesData).filter (s) -> _.findWhere(searches, id: s.id)
  searchesData = _.difference(searchesData, toDelete)
  Promise.resolve(searchesData)

UserActions.saveArticles.listen (articles) ->
  ids = _.pluck(articles, 'id')
  console.log('saving articles', ids)
  articlesData = articlesData.concat(articles)
  articlesData = _(articlesData).uniq (a) -> a.id
  Promise.resolve(articles)

UserActions.loadArticles.listen ->
  Promise.resolve(articlesData).then(@completed)

UserActions.removeArticles.listen (articles) ->
  toDelete = _(articlesData).filter (a) -> _.findWhere(articles, id: a.id)
  articlesData = _.difference(articlesData, toDelete)
  Promise.resolve(_.pluck(toDelete, 'id')).then(@completed)

UserActions.emailArticles.listen (articles) ->
  Promise.resolve(_.pluck(articles, 'id')).then(@completed)

module.exports = UserActions
