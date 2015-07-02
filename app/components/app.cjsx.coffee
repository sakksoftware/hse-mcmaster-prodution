Button = ReactBootstrap.Button
UserActions = require('actions/user_actions')
SearchHeader = require('components/search/search_header')
SearchBox = require('components/search/search_box')
ResultBox = require('components/results/result_box')

module.exports = React.createClass
  componentWillMount: ->
    UserActions.loadUsers(@handleLoad, @handleError)

  handleLoad: (users, statusCode, xhr) ->
    console.log("successfully loaded users", users)

  handleError: (xhr, statusCode, statusText) ->
    console.log("error", xhr, statusCode, statusText)

  render: ->
    results = [
      {
        title: 'Article Title A'
        created_at: new Date() - (60 * 60 * 24 * 100)
        quality: 7.0
        description: 'Some Crazy long description goes here.....'
        category: 'International Organizations Document'
      }
      {
        title: 'Article Title B'
        created_at: new Date() - (60 * 60 * 24 * 100)
        quality: 7.0
        description: 'Lots of stuff goes here! Very Interesting right?.....'
        category: 'Superhero Marvel Movies'
      }
    ]

    <div id="app">
      <SearchHeader />
      <SearchBox />
      <ResultBox results={results} />
    </div>
