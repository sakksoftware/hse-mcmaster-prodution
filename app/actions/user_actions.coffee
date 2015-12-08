API = require('lib/api')
FetchAPI = require('lib/fetch_api')
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
  loadCuratedSearches: {asyncResult: true}
  toggleSaveSearch: {asyncResult: true}
  saveSearch: {asyncResult: true}
  toggleSubscribeToSearch: {asyncResult: true}
  toggleSubscribeToSavedSearch: {asyncResult: true}
  toggleSubscribeToCuratedSearch: {asyncResult: true}
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

UserActions.unsubscribe.listen ->
  API.update('user/unsubscribe').done(@completed).fail(@failed)

UserActions.loadSearches.listen ->
  API.read('/user/searches').done(@completed).fail(@failed)

UserActions.toggleSaveSearch.listen (search) ->
  if search.saved
    # TODO: very HACKY! need to grab state from the store since the state of the
    # search param might be stale and does not contain the saved_search_id
    SearchStore = require('stores/search_store')
    id = search.saved_search_id || SearchStore.state.search?.saved_search_id

    UserActions.removeSearches([{id: id}]).then(@completed).catch(@failed)
  else
    UserActions.saveSearch(search).then(@completed).catch(@failed)

UserActions.saveSearch.listen (search) ->
  search = _.omit(search, ['results', 'filters'])
  API.create('/user/searches', search).done(@completed).fail(@failed)

UserActions.removeSearches.listen (searches) ->
  API.create('/user/searches/remove', _.pluck(searches, 'id')).done(@completed).fail(@failed)

UserActions.saveArticles.listen (articles) ->
  ids = _.pluck(articles, 'id')
  API.create('/user/articles/save', ids).done(@completed).fail(@failed)

UserActions.loadArticles.listen ->
  API.read('/user/articles').done(@completed).fail(@failed)

UserActions.removeArticles.listen (articles) ->
  API.create('/user/articles/remove', _.pluck(articles, 'id')).done(@completed).fail(@failed)

UserActions.emailArticles.listen (articles) ->
  API.create('/user/articles/email', _.pluck(articles, 'id')).done(@completed).fail(@failed)

UserActions.toggleSubscribeToSearch.listen (search) ->
  if search.saved
    UserActions.toggleSubscribeToSavedSearch(search.saved_search_id, search.subscribed).then(@completed).catch(@failed)
  else
    UserActions.saveSearch(search).catch(@failed).then (saved_search) =>
      UserActions.toggleSubscribeToSavedSearch(saved_search.id, saved_search.subscribed).then(@completed).catch(@failed)

UserActions.toggleSubscribeToSavedSearch.listen (id, subscribed) ->
  if subscribed
    API.create("/user/searches/#{id}/unsubscribe").done(@completed).fail(@failed)
  else
    API.create("/user/searches/#{id}/subscribe").done(@completed).fail(@failed)

UserActions.toggleSubscribeToCuratedSearch.listen (curated_search) ->
  if curated_search.subscribed
    id = curated_search.saved_search_id
    FetchAPI.create("/user/searches/#{id}/unsubscribe").catch(@failed).then =>
      FetchAPI.destroy("/user/searches/#{id}").then(@completed).catch(@failed)
  else
    search = curated_search
    FetchAPI.create("/user/searches", search).catch(@failed).then (saved_search) =>
      id = saved_search.id
      FetchAPI.create("/user/searches/#{id}/subscribe").then(@completed).catch(@failed)

UserActions.loadCuratedSearches.listen ->
  FetchAPI.read('/user/curated_searches').then(@completed).catch(@failed)

module.exports = UserActions
