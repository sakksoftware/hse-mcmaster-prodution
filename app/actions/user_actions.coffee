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
  updateUser: {asyncResult: true}
  loadUser: {asyncResult: true}

UserActions.createUser.listen ->
  API.create('users', user).done(@completed).fail(@failed)

UserActions.loadUser.listen ->
  API.read('user').done(@completed).fail(@failed)

UserActions.updateUser.listen (user) ->
  API.update('user', user).done(@completed).fail(@failed)

UserActions.loginUser.listen (user) ->
  API.create('user', user).fail(@failed).done (user) =>
    $.ajaxSetup
      beforeSend: (xhr) =>
        xhr.setRequestHeader('X-Authenticate', user.token)
    @completed(user)

module.exports = UserActions
