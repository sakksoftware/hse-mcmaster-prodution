API = require('lib/api')
config = require('config')[window.ENV]
if config.useMocks
  return module.exports = require('mocks/actions/user_actions')

# if userLoggedIn
#   $.beforeSend => addHTTPHeader('X-Authenticate', token)

UserActions = Reflux.createActions
  createUser: {}
  loginUser: {}
  updateUser: {asyncResult: true}
  loadUser: {asyncResult: true}

UserActions.loadUser.listen ->
  API.read('/user').done(@completed).fail(@failed)

UserActions.updateUser.listen ->
  API.update('/user').done(@completed).fail(@failed)

module.exports = UserActions
