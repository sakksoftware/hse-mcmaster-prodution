Input = ReactBootstrap.Input
SearchActions = require('actions/search_actions')

module.exports = React.createClass
  displayName: 'SearchBar'
  propTypes:
    query: React.PropTypes.string.isRequired
    onSearch: React.PropTypes.func.isRequired

  handleSubmit: (e) ->
    e.preventDefault()
    @props.onSearch?(@refs.search.lastSuggestionsInputValue)

  fetchSuggestions: (query, callback) ->
    handleLoadSuggestions = (data) -> callback(null, data.suggestions)
    handleError = -> console.log('Error: cannot load suggestions')
    SearchActions.suggestions query, handleLoadSuggestions, handleError

  getSuggestionValue: (suggestion, input) ->
    suggestion.query

  renderSuggestion: (suggestion, input) ->
    <span>
      <strong>{suggestion.query.slice(0, input.length)}</strong>
      {suggestion.query.slice(input.length)} ({suggestion.count})
    </span>

  render: ->
    inputAttributes =
      placeholder: "Search..."
      value: @props.query

    <form action="#" onSubmit={@handleSubmit} className="search-bar">
      <Autosuggest suggestions={@fetchSuggestions} suggestionValue={@getSuggestionValue} suggestionRenderer={@renderSuggestion} inputAttributes={inputAttributes} ref="search" />
      <button>Search</button>
    </form>