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
  subscribeToSearch: {asyncResult: true}
  removeSearches: {asyncResult: true}
  saveArticles: {asyncResult: true}
  loadArticles: {asyncResult: true}
  removeArticles: {asyncResult: true}
  emailArticles: {asyncResult: true}

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
  # mocks.loadSearches().then(@completed)
  API.read('/user/searches', apiBase: 'http://hse.stage2.droxic.com').done(@completed).fail(@failed)

UserActions.saveSearch.listen (search) ->
  # mocks.saveSearch(search).then(@completed)
  API.create('/user/searches', search, apiBase: 'http://hse.stage2.droxic.com').done(@completed).fail(@failed)

UserActions.removeSearches.listen (searches) ->
  # mocks.removeSearches(searches).then(@completed)
  API.create('/user/searches/remove', _.pluck(searches, 'id'), apiBase: 'http://hse.stage2.droxic.com').done(@completed).fail(@failed)

UserActions.saveArticles.listen (articles) ->
  # mocks.saveArticles(articles).then(@completed)
  ids = _.pluck(articles, 'id')
  API.create('/user/articles/save', ids, apiBase: 'http://hse.stage2.droxic.com').done(@completed).fail(@failed)

UserActions.loadArticles.listen ->
  # mocks.loadArticles().then(@completed)
  API.read('/user/articles', apiBase: 'http://hse.stage2.droxic.com').done(@completed).fail(@failed)

UserActions.removeArticles.listen (articles) ->
  # mocks.removeArticles(articles).then(@completed)
  API.create('/user/articles/remove', _.pluck(articles, 'id'), apiBase: 'http://hse.stage2.droxic.com').done(@completed).fail(@failed)

UserActions.emailArticles.listen (articles) ->
  # mocks.emailArticles(articles).then(@completed)
  API.create('/user/articles/email', _.pluck(articles, 'id'), apiBase: 'http://hse.stage2.droxic.com').done(@completed).fail(@failed)

module.exports = UserActions
