API = require('lib/api')

UserActions = Reflux.createActions
  createUser: {}
  loginUser: {}
  updateUser: {asyncResult: true}
  loadUser: {asyncResult: true}

UserActions.loadUser.listen ->
  API.read('/user').done(@completed).fail(@failed)

UserActions.updateUser.listen (user) ->
  @completed.trigger(user)

module.exports = UserActions
