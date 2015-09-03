API = require('lib/api')
config = require('config')[window.ENV]
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

UserActions.createUser.listen (user) ->
  API.create('users', user).done(@completed).fail(@failed)

UserActions.loadUser.listen ->
  API.read('user').done(@completed).fail(@failed)

UserActions.updateUser.listen (user) ->
  API.update('user', user).done(@completed).fail(@failed)

UserActions.loginUser.listen (user) ->
  API.create('user/login', user)
    .fail (xhr) =>
      errors = null

      # TODO: does this belong here? server error JSON adapter
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

module.exports = UserActions
