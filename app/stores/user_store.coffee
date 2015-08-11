API = require('lib/api')
UserActions = require('actions/user_actions')

module.exports = Reflux.createStore
  listenables: [UserActions],
  onCreateUser: (user, success, error) ->
    API.create 'users', { user: user },
      success: success
      error: error

  onLoginUser: (user, success, error) ->
    API.create 'users', { user: user },
      success: success
      error: error
