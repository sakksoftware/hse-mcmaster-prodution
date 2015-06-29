API = require('lib/api')
UserActions = require('actions/user_actions')

module.exports = Reflux.createStore
  listenables: [UserActions]

  # users list
  loadUsers: (success, error) ->
    API.read "users",
      success: success,
      error: error

  # user details
  loadUser: (userId, success, error) ->
    API.read "users/#{userId}",
      success: success,
      error: error