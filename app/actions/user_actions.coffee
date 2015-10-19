API = require('lib/api')
config = require('config')
if config.useMocks
  return module.exports = require('mocks/actions/user_actions')

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

UserActions.saveSearch.listen (search) ->
  API.create('/user/searches', search).done(@completed).fail(@failed)

module.exports = UserActions
