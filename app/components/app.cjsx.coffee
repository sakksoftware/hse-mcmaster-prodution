Button = ReactBootstrap.Button
UserActions = require('actions/user_actions')
SearchHeader = require('components/search/search_header')
SearchBox = require('components/search/search_box')

module.exports = React.createClass
  componentWillMount: ->
    UserActions.loadUsers(@handleLoad, @handleError)

  handleLoad: (users, statusCode, xhr) ->
    console.log("successfully loaded users", users)

  handleError: (xhr, statusCode, statusText) ->
    console.log("error", xhr, statusCode, statusText)

  render: ->
    <div id="app">
      <SearchHeader />
      <SearchBox />
    </div>
