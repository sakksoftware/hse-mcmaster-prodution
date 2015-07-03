Button = ReactBootstrap.Button
SearchActions = require('actions/search_actions')
SearchHeader = require('components/search/search_header')
SearchBox = require('components/search/search_box')
ResultBox = require('components/results/result_box')

module.exports = React.createClass
  displayName: 'App'
  getInitialState: ->
    search: null

  handleSearch: (query) ->
    SearchActions.search(query, @handleLoad, @handleError)

  handleLoad: (search, statusCode, xhr) ->
    @setState(search: search)

  handleError: (xhr, statusCode, statusText) ->
    console.log("error", xhr, statusCode, statusText)

  render: ->
    results =
      if @state.search != null
        <ResultBox results={@state.search.results} />

    <div id="app">
      <SearchHeader />
      <SearchBox search={@state.search} onSearch={@handleSearch} />
      {results}
    </div>
