Button = ReactBootstrap.Button
UserActions = require('actions/user_actions')

module.exports = React.createClass
  componentWillMount: ->
    UserActions.loadUsers(@handleLoad, @handleError)

  handleLoad: (users, statusCode, xhr) ->
    console.log("successfully loaded users", users)

  handleError: (xhr, statusCode, statusText) ->
    console.log("error", xhr, statusCode, statusText)

  render: ->
    <div id="app">
      <Button>Press Me Down</Button>
    </div>
