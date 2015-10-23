API = require('lib/api')
config = require('config')
mocks = require('mocks/actions/user_actions')

if config.useMocks
  return module.exports = mocks

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

UserActions.createUser.listen (user) ->
  user.language = Cookies.get('lang')
  API.create('users', user).done(@completed).fail(@failed)

UserActions.loadUser.listen ->
  API.read('user').done(@completed).fail(@failed)

UserActions.updateUser.listen (user) ->
  API.update('user', user).done(@completed).fail(@failed)

UserActions.loginUser.listen (user) ->
  API.create('user/login', user, skipErrorHandlingFor: 403)
    .fail (xhr) =>
      errors = null

      if xhr.status == 403
        user = { errors: {email: 'invalid', password: 'invalid'} }
        xhr.responseText = JSON.stringify(user)

      @failed(xhr)
    .done (user) =>
      @completed(user)

UserActions.logoutUser.listen ->
  API.read('user/logout').done(@completed).fail(@failed)

UserActions.forgotPassword.listen (data) ->
  API.create('user/forgot_password', data).done(@completed).fail(@failed)

UserActions.resetPassword.listen (data) ->
  API.create('user/reset_password', data).done(@completed).fail(@failed)

UserActions.loadRegion.listen ->
  API.read('geo').done(@completed).fail(@failed)
  # Promise.resolve({region: 'ontario'})

UserActions.unsubscribe.listen ->
  API.create('user/unsubscribe').done(@completed).fail(@failed)

UserActions.loadSearches.listen ->
  mocks.loadSearches().then(@completed)
  # TODO: switch when implemented
  # API.read('/user/searches').done(@completed).fail(@failed)

UserActions.saveSearch.listen (search) ->
  mocks.saveSearch(search).then(@completed)
  # TODO: switch when implemented
  # API.create('/user/searches', search).done(@completed).fail(@failed)

UserActions.removeSearches.listen (searches) ->
  mocks.removeSearches(searches).then(@completed)
  # TODO: switch when implemented
  # API.create('/user/searches/remove', _.pluck(searches, 'id'))
  # TODO: will need a different API endpoint to remove all searches by id
  # requests = []
  # for search in searches
  #   requests.push API.destroy("/user/searches/#{search.id}")

  $.when(requests).done(@completed).fail(@failed)

UserActions.saveArticles.listen (articles) ->
  mocks.saveArticles(articles).then(@completed)
  # TODO: uncomment when implemented
  # ids = _.pluck(articles, 'id')
  # API.create('/user/articles/save', ids).done(@completed).fail(@failed)

UserActions.loadArticles.listen ->
  mocks.loadArticles().then(@completed)
  # TODO: uncomment when implemented
  # API.read('/user/articles').done(@completed).fail(@failed)

module.exports = UserActions
